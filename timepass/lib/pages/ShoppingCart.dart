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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/Model.dart';
import 'package:timepass/pages/CheckOutPage.dart';
import 'package:timepass/pages/HomePage.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:timepass/theme.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}


class _ShoppingCartState extends State<ShoppingCart>{
  var scaffoldKey = GlobalKey<ScaffoldState>();

//  var sum=0;
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
        key: scaffoldKey,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 100,
                child: DrawerHeader(
                  child: Text(
                    'Grocery',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24.0,left: 5.0,bottom: 2.0),
            child: Row(
              children: <Widget>[
                IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                  icon: FaIcon(FontAwesomeIcons.alignLeft),
                  onPressed: () => scaffoldKey.currentState.openDrawer(),
                ),
                Text(
                  'Shopping-Cart',
                  style: TextStyle(
                    fontSize: 30,
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
         return CircularProgressIndicator();
        }else{
          return Expanded(
            child: ListView.builder(
                itemCount: snapshot?.data?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder:(BuildContext context,int index){
//                  SubCategory subCategory = snapshot.data[index];
//                sum=sum+snapshot.data[index]["subPrice"];
                  return GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,right: 10,bottom: 5
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          elevation: 2,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 130.0,
                                height: 128.0,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot.data[index]["subImageUrl"]),
                                        fit: BoxFit.cover
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 9,right: 3),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween ,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[index]["subName"],
                                            style: TextStyle(
                                                fontSize: 18.0
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            padding: EdgeInsets.zero,
//                                          margin: EdgeInsets.only(left: 120),
                                            child: IconButton(
                                             icon: Icon(Icons.close),
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              'V:'+snapshot.data[index]["subPrice"].toString(),
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 30,
                                            child: OutlineButton(
                                              child: Icon(Icons.add),
                                              shape:RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0)
                                              ),
                                              onPressed:(){}),
                                          ),
                                          Text(
                                            '1',
                                            style: TextStyle(
                                              fontSize: 18
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            child: OutlineButton(
                                                child: FaIcon(FontAwesomeIcons.minus),
                                                shape:RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                ),
                                                onPressed:(){}),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5,bottom:5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Price : ',
                                              style: TextStyle(
                                                fontSize: 20
                                              ),
                                            ),
                                            Text(
                                              '2351733',
                                              style: TextStyle(
                                                fontSize: 20
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
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



