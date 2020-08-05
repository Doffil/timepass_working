import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/pages/SupportChat.dart';
import 'package:timepass/services/Service.dart';

import 'Categories.dart';
class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  int mobileNo;
  bool loading = true;
  int changeColor;
  @override
  void initState() {
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
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Categories()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            drawer: MyDrawer(),
            body: loading
                ? Center(child: CircularProgressIndicator())
                : Column(
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
                            'Support Tickets',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ]),
                Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: FutureBuilder(
                        future: Service.getAllTickets(mobileNo),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data["success"] == false) {
                            return Center(child: Text('No Tickets Found !!!'),);
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data["success"] == true) {
                            final orderDetails = snapshot.data["data"];
                            
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SupportChat(ticketDetails:orderDetails[index])));
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
                                                  'Subject',
                                                  style: GoogleFonts.inter(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 14,
                                                      fontStyle:
                                                      FontStyle.normal,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  'Ticket Creation Date',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    orderDetails[index]
                                                    ["subject"].toString(),
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                orderDetails[index]
                                                ["created_at"].toString(),
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
                                                    ["category"].toString(),
                                                    style: TextStyle(
                                                        color: Colors.orange)),
                                                Text(
                                                    orderDetails[index]
                                                    ["ticket_status"]["status_name"].toString(),
                                                    style: TextStyle(
                                                        color:orderDetails[index]
                                                        ["ticket_status"]["status_name"]=="Open"?
                                                            Colors.green:
                                                        orderDetails[index]
                                                        ["ticket_status"]["status_name"]=="In Process"?
                                                            Colors.blue:Colors.red
                                                    ),
                                                ),
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
      ),
    );
  }

}
