
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/pages/CheckOutPage.dart';
import 'package:timepass/pages/HomePage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPresent = true;
  int count1=0;
//  var sum=0;
  noItemsInCart() {
    return Expanded(
      child: Center(
        child: Text('No items in cart'),
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
                        fontWeight: FontWeight.bold),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchList()));
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.shoppingBag),
                title: Text('Shopping-Cart'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShoppingCart()));
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.userCircle),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('Language'),
                onTap: () {
                  //yet to implement
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.signOutAlt),
                title: Text('Sign-Out'),
                onTap: () {
                  //add at the last
                },
              ),
            ],
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 2.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                              icon: FaIcon(FontAwesomeIcons.alignLeft),
                              color: Colors.black87,
                              onPressed: () =>
                                  scaffoldKey.currentState.openDrawer(),
                            ),
                            Text(
                              'Shopping-Cart',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                              ),
                            ],
                          ),
                          child: IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                            icon: FaIcon(FontAwesomeIcons.trash,
                                color: Colors.red, size: 18),
                            color: Colors.black,
                            onPressed: () async {
                              await DatabaseHelper.instance.deleteAll();
                              setState(() {
                                getAllItems();
                              });
                            },
                          ),
                        ),
                      ])),
              getData(),
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 1.0, offset: Offset(0.0, 0.75)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 2, right: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Rs.1200',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        RaisedButton.icon(
                          color: Colors.white,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOutPage(),
                              ),
                            );
                          },
                          label: Text(
                            'Place Order',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          icon: FaIcon(
                            FontAwesomeIcons.shoppingCart,
                            size: 15,
                            color: Colors.black87,
                          ),
                          shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(8.0),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]));
  }

  Future getAllItems() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartLength', queryRows.length);
    print(queryRows.length);
    return queryRows;
  }

  Widget getData() {
    return FutureBuilder(
      future: getAllItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return CircularProgressIndicator();
        } else {
          return Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: snapshot?.data?.length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
//                  SubCategory subCategory = snapshot.data[index];
//                sum=sum+snapshot.data[index]["subPrice"];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete,color: Colors.white,size: 30,),
                      ),
//
//                      onDismissed: (direction) async {
//                        int rowAffected = await DatabaseHelper.instance
//                            .delete(snapshot.data[index]["subId"]);
//                        setState(() {
//                          getAllItems();
//                        });
//                      },
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              title: const Text("Confirm",),
                              content: const Text("Are you sure you wish to delete this item?"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: ()async{
                                      int rowAffected = await DatabaseHelper.instance
                                          .delete(snapshot.data[index]["subId"]);
                                      setState(() {
                                        getAllItems();
                                      });
                                      Navigator.of(context).pop(true);
                                      Flushbar(
                                        margin: EdgeInsets.all(8),
                                        borderRadius: 8,
                                        backgroundColor: Colors.red,
                                        flushbarPosition: FlushbarPosition.TOP,
                                        message: "You have successfully removed the item from cart!!!",
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                   },
                                    child: const Text("DELETE",style: TextStyle(color: Colors.red),)
                                ),
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text("CANCEL"),
                                ),
                              ],
                            );
                          },
                        );
                      },



                      child: GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 7, right: 7, bottom: 5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 2,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 130.0,
                                    height: 86.0,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data[index]["subImageUrl"]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
//                                    margin: EdgeInsets.zero,
                                      padding: EdgeInsets.only(
                                          left: 9, right: 3, top: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
//                                          crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data[index]["subName"],
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 15,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () async {
                                                  int rowAffected =
                                                      await DatabaseHelper
                                                          .instance
                                                          .delete(snapshot
                                                                  .data[index]
                                                              ["subId"]);
                                                  setState(() {
                                                    getAllItems();
                                                  });
//                                           widget.valueSetter(widget.id1.subCategory[i]);
                                                },
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8, right: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Rs.100',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: OutlineButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .plus,
                                                            size: 10,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              count1++;
                                                            });
                                                          }),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 7,
                                                              right: 7),
                                                      child: Text(
                                                        '$count1',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      child: OutlineButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            size: 10,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              if(count1!=1)
                                                                count1--;
                                                            });
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
      },
    );
  }
}

//
//IconButton(
////                    icon: Icon(Icons.menu,size: 30,),
//icon: FaIcon(FontAwesomeIcons.trashAlt,color:Colors.red,),
//onPressed: ()async{
//await DatabaseHelper.instance.deleteAll();
//setState(() {
//getAllItems();
//});
//},
//),
