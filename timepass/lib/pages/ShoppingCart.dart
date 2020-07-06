import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timepass/Model.dart';

class ShoppingCart extends StatefulWidget {
  final List<SubCategory>cart1;
  ShoppingCart({Key key, @required this.cart1}) :super(key: key);
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ListView.separated(
            itemCount:widget.cart1.length,
              itemBuilder:(context,index){
                return ListTile(
                  title: Text(widget.cart1[index].subName),
                  trailing: Text(widget.cart1[index].subPrice),
                );
              },
              separatorBuilder: (context,index){
                return Divider();
              },
            shrinkWrap: true,
          )
        ],
      ),
    );
  }
}
