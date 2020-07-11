//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:timepass/Model.dart';
//
//class ShoppingCart extends StatefulWidget {
//  final List<SubCategory>cart1;
//  ShoppingCart({Key key, @required this.cart1}) :super(key: key);
//  @override
//  _ShoppingCartState createState() => _ShoppingCartState();
//}
//
//class _ShoppingCartState extends State<ShoppingCart> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Column(
//        children: <Widget>[
//          ListView.separated(
//            itemCount: widget?.cart1?.length ?? 0,
//              itemBuilder:(context,index){
//                return ListTile(
//                  title: Text(widget.cart1[index].subName),
//                  trailing: Text(widget.cart1[index].subPrice),
//                );
//              },
//              separatorBuilder: (context,index){
//                return Divider();
//              },
//            shrinkWrap: true,
//          )
//        ],
//      ),
//    );
//  }
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timepass/Model.dart';
import 'package:timepass/pages/CheckOutPage.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:timepass/theme.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}


class _ShoppingCartState extends State<ShoppingCart>{

  noItemsInCart(){
    return Center(
        child: Text(
          'No items in cart'
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0,left: 5.0,bottom: 2.0),
            child: Text(
              'Shopping-Cart',
              style: TextStyle(
                fontSize: 30,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          getData(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=> CheckOutPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Check-Out',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
                RaisedButton(
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  onPressed: ()async{
                    await DatabaseHelper.instance.deleteAll();
                    setState(() {
                      getAllItems();
                    });
                  },
                  child: Text(
                    'Clear Cart',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
  Future getAllItems() async{
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
    return queryRows;
  }

   Widget getData(){
    return FutureBuilder(
      future: getAllItems(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
          return Center(
            child: Text(
              'No data found',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          );
        }else{
          return Flexible(
            child: ListView.builder(
                itemCount: snapshot?.data?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder:(BuildContext context,int index){
//                  SubCategory subCategory = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 330,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          elevation: 9,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot.data[index]["subImageUrl"]),
                                          fit: BoxFit.cover
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(blurRadius: 2.0)
                                      ]),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0,top: 9.0),
                                      child: Text(
                                        snapshot.data[index]["subName"],
                                        style: TextStyle(
                                            fontSize: 18.0
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7.0,left: 10.0),
                                      child: Text(
                                        snapshot.data[index]["subPrice"].toString(),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(right: 23.0),
                                            child: ButtonTheme(
                                              minWidth:20.0,
                                              child: OutlineButton(
                                                child: Icon(Icons.favorite_border),
                                                shape:RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                ),
                                              ),
                                            ),
                                          ),
                                          ButtonTheme(
                                            minWidth: 20.0,
                                            child: OutlineButton(
                                              child: Icon(Icons.delete),
                                              shape:RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(6.0)
                                              ),
                                              onPressed:() async{
                                                int rowAffected = await DatabaseHelper.
                                                instance.delete(snapshot.data[index]["subId"]);
                                                setState(() {
                                                  getAllItems();
                                                });
//                                           widget.valueSetter(widget.id1.subCategory[i]);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        }
      },
    );
  }
}



