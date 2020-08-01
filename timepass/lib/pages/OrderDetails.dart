import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/main.dart';
import 'package:timepass/pages/OrderFurtherDetails.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/sqlite/db_helper.dart';

import 'Categories.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int mobile_no;
  bool loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMobileNo();
  }

  getMobileNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile_no = prefs.getInt('customerMobileNo');
    setState(() {
      loading=false;
    });
    print(mobile_no.toString());
  }

  Future<bool> _onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Categories()));
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.shoppingBag),
                  title: Text('Shopping-Cart'),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(

                            type: PageTransitionType
                                .rightToLeft,
                            duration:
                            Duration(milliseconds: 500),
                            child: ShoppingCartCopy()));
                  },
                ),

                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Orders'),
                  onTap: () {
                    //yet to implement
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrderDetails()));
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.userCircle),
                  title: Text('Support'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()));
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
                  leading: FaIcon(FontAwesomeIcons.userCircle),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()));
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.signOutAlt),
                  title: Text('Sign-Out'),
                  onTap: ()async {
                    //add at the last
                    await DatabaseHelper.instance.deleteAll();
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    FirebaseAuth.instance.signOut();
                    prefs.setString('customerName', null);
                    prefs.setString('customerEmailId', null);
                    prefs.setString('customerId', null);
                    prefs.setBool("isLoggedIn", false);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));                        },
                ),
              ],
            ),
          ),
          body:loading?Center(child: CircularProgressIndicator()):
          Column(
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
                              color: Colors.black,
                              onPressed: () =>
                                  scaffoldKey.currentState.openDrawer(),
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ])),
              Expanded(
              child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
                child: FutureBuilder(
                  future: Service.getOrders(mobile_no),
                  builder: (context, snapshot) {
//                    if (snapshot.connectionState == ConnectionState.done && snapshot?.data?.length==0&&
//                        snapshot.data["success"] == false) {
//                      return Container(
//                        alignment: Alignment.center,
//                        margin: EdgeInsets.only(left: 30, right: 30),
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Text(
//                              snapshot.data["msg"].toString(),
//                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),
//                            ),
//                          ],
//                        ),
//                      );
//                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData &&
                        snapshot.data["success"] == true) {
                      final orderDetails = snapshot.data["data"];
                      print(orderDetails);
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context)=>OrderFurtherDetails(details:orderDetails[index])));
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              margin: EdgeInsets.only(left: 9,right: 9,bottom: 7,top: 5),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Order No.',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'Order Creation Date',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            orderDetails[index]["Invoice_No"],
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                        Text(
                                          orderDetails[index]["created_at"],
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(orderDetails[index]["order_status"]["status_name"],
                                          style: TextStyle(color: Colors.orange)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: orderDetails?.length ?? 0,
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )
              )],
          )),
    );
  }
}
