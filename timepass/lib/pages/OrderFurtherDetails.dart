import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/main.dart';
import 'package:timepass/pages/OrderDetails.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/sqlite/db_helper.dart';

import 'Categories.dart';
import 'ProfilePage.dart';

class OrderFurtherDetails extends StatefulWidget {
  final details;
  const OrderFurtherDetails({Key key, this.details}) : super(key: key);
  @override
  _OrderFurtherDetailsState createState() => _OrderFurtherDetailsState();
}

class _OrderFurtherDetailsState extends State<OrderFurtherDetails> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Widget getData() {}

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
                    MaterialPageRoute(builder: (context) => Categories()));
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.shoppingBag),
              title: Text('Shopping-Cart'),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 500),
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
              leading: FaIcon(FontAwesomeIcons.userCircle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.signOutAlt),
              title: Text('Sign-Out'),
              onTap: () async {
                //add at the last
                await DatabaseHelper.instance.deleteAll();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                FirebaseAuth.instance.signOut();
                prefs.setString('customerName', null);
                prefs.setString('customerEmailId', null);
                prefs.setString('customerId', null);
                prefs.setBool("isLoggedIn", false);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
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
                        widget.details["Invoice_No"],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ]),
            Card(
              elevation: 4,
              color: Colors.white,
              margin: EdgeInsets.only(left: 9, right: 9, top: 5,bottom: 5),
              child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.details["Invoice_No"],
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Text(
                          widget.details["created_at"],
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(widget.details["order_status"]["status_name"],
                          style: TextStyle(color: Colors.orange)),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.details["order_details"].length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2.0,
                  margin: EdgeInsets.only(left: 9, right: 9, bottom: 7),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Product Name : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.details["order_details"][index]
                                  ["product_variable"]["product"]["name"],
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Qty : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.details["order_details"][index]["quantity"],
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Variable Size : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.details["order_details"][index]
                                      ["product_variable"]
                                  ["product_variable_options_name"],
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Price : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'Rs.'+(double.parse(widget.details["order_details"][index]["quantity"])*
                                  widget.details["order_details"][index]["variable_selling_price"]).toString(),
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.teal[400],
                          thickness: 2,
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
            ),
            Card(
              elevation: 2.0,
              margin: EdgeInsets.only(left: 9, right: 9, bottom: 7, top: 5),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Price Details',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Subtotal:'),
                        Text(widget.details["sub_total"].toString())
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Tax :'),
                        Text(widget.details["tax"].toString())
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Discount :'),
                        Text(widget.details["discount"].toString())
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Delivery Charges :'),
                        Text(widget.details["delivery_charge"].toString())
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Amount :',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Rs.' + widget.details["total_amount"].toString(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2.0,
              margin: EdgeInsets.only(left: 9, right: 9, bottom: 7, top: 5),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address Details',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Address:'),
                        Flexible(
                          child: Text(widget.details["address"]
                                  ["address_line_1"] +
                              ',' +
                              widget.details["address"]["address_line_2"] +
                              ',' +
                              widget.details["address"]["pincode"].toString()),
                        )
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Mobile No.:'),
                        Text(widget.details["customer"]["mobile_no"].toString())
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Alternate Mobile No.:'),
                        Text(widget.details["alternate_no"].toString())
                      ],
                    ),
                    Divider(
                      height: 25,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Categories()));
                },
                icon: Icon(
                  Icons.file_download,
                  size: 18,
                ),
                label: Text(
                  'Download Invoice',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderDetails()));
                },
                icon: FaIcon(
                  FontAwesomeIcons.ticketAlt,
                  size: 18,
                ),
                label: Text(
                  'Support',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            )
          ],
        ),
      ),
    );
  }
}
