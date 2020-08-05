import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/pages/OrderFurtherDetails.dart';
import 'package:timepass/services/Service.dart';
import 'Categories.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int mobileNo;
  bool loading = true;
  bool paid = false;
  @override
  void initState() {
    paid = false;
    super.initState();
    getMobileNo();
  }

  getMobileNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNo = prefs.getInt('customerMobileNo');
    setState(() {
      loading = false;
    });
    print(mobileNo.toString());
  }

  Future<bool> onBackPressed() {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => Categories()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
          key: scaffoldKey,
          drawer: MyDrawer(),
          body: loading
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                        future: Service.getOrders(mobileNo),
                        builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data["success"] == false) {
                     return Center(child: Text('No Orders Found !!!'),);
                    }
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data["success"] == true) {
                            final orderDetails = snapshot.data["data"];
                            print(orderDetails);
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                if (orderDetails[index]["payment_status"]
                                        .toString()
                                        .toUpperCase() ==
                                    "PAID") {
                                  paid = true;
                                } else {
                                  paid = false;
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderFurtherDetails(
                                                    details:
                                                        orderDetails[index])));
                                  },
                                  child: Card(
                                    elevation: 4,
                                    color: Colors.white,
                                    margin: EdgeInsets.only(
                                        left: 9, right: 9, bottom: 7, top: 5),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Order No.',
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  'Order Creation Date',
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  orderDetails[index]
                                                      ["Invoice_No"],
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ),
                                              Text(
                                                orderDetails[index]
                                                    ["created_at"],
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                    orderDetails[index]
                                                            ["order_status"]
                                                        ["status_name"],
                                                    style: TextStyle(
                                                        color: Colors.orange)),
                                                Container(
                                                  height: 30,
                                                  child: RaisedButton(
                                                    onPressed: () {},
                                                    color: paid
                                                        ? Colors.green
                                                        : Colors.red,
                                                    child: Text(
                                                      orderDetails[index]
                                                              ["payment_status"]
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
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
                    ))
                  ],
                )),
    );
  }
}
