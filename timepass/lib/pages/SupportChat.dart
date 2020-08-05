import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MyDrawer.dart';
class SupportChat extends StatefulWidget {
  final ticketDetails;

  const SupportChat({Key key, this.ticketDetails}) : super(key: key);
  @override
  _SupportChatState createState() => _SupportChatState();
}

class _SupportChatState extends State<SupportChat> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: MyDrawer(),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ListView(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.alignLeft),
                        color: Colors.black,
                        onPressed: () => scaffoldKey.currentState.openDrawer(),
                      ),
                      Text(
                        "Ticket Chat",
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
                              widget.ticketDetails
                              ["subject"].toString(),
                              style: TextStyle(
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                        Text(
                         widget.ticketDetails
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
                              widget.ticketDetails
                              ["category"].toString(),
                              style: TextStyle(
                                  color: Colors.orange)),
                          Text(
                            widget.ticketDetails
                            ["ticket_status"]["status_name"].toString(),
                            style: TextStyle(
                                color:widget.ticketDetails
                                ["ticket_status"]["status_name"]=="Open"?
                                Colors.green:
                                widget.ticketDetails
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
          ],
        ),
      ),
    );
  }
}
