import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timepass/Model.dart';
import 'package:flutter/painting.dart';

class SubProduct extends StatelessWidget {

  final Welcome id1;
  var len;
  SubProduct({Key key, @required this.id1}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new ListView.builder(
        itemCount: id1.subCategory.length,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, i) {
          len=i;
          return Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Card(
              elevation: 20,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: NetworkImage(id1.imageUrl),
                                fit: BoxFit.cover),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 2.0)
                            ]),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext conext) {
                          return AlertDialog(
                            title: Text('Not in stock'),
                            content:
                            const Text('This item is no longer available'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(30.0),
                        child: Text(id1.subCategory[i].subName),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


