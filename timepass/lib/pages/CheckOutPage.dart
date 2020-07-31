import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/GoogleMapPage.dart';
import 'package:timepass/pages/RazorpayHome.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/payment/check.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/sqlite/db_helper.dart';

import 'package:http/http.dart' as http;


class CheckOutPage extends StatefulWidget {
  final String currentAddress;
  final list_of_addresses;
  const CheckOutPage({Key key, this.currentAddress, this.list_of_addresses}) : super(key: key);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

  String _currentAddress;
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  int sum = 0;
  int get_address_id;
  var rateData;
  bool _loading=true;
  String promocode="";
  List queryRows=[];
  int mobile_no;
  var razorpay_id;

  @override
  void initState() {
    print('loaded');
    _loading=true;
    _currentAddress=widget.list_of_addresses[widget.list_of_addresses.length-1]
    ["address_line_1"].toString()+","
        +widget.list_of_addresses[widget.list_of_addresses.length-1]
        ["address_line_2"].toString();
    get_address_id=widget.list_of_addresses[widget.list_of_addresses.length-1]["id"];
    getRate();
    super.initState();
  }

  getRate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobile_no=prefs.getInt('customerMobileNo');
    queryRows=await DatabaseHelper.instance.queryAll();
    if(queryRows.length!=0){
      promocode=promocodeText.text;
      if(promocode.length>0){
        Service.getRates(queryRows, get_address_id, mobile_no,promocode).then((value){
          if(value["success"]==true){
            rateData=value["data"];
            setState(() {
              _loading=false;
            });
            print('discount is:'+rateData["discount"].toString());
          }
        });
      }else{
        Service.getRates(queryRows, get_address_id, mobile_no).then((value){
          if(value["success"]==true){
            rateData=value["data"];
            setState(() {
              _loading=false;
            });
            print('amount is:'+rateData["amount"].toString());
          }
        });
      }

    }else{
      print('could not get data from database');
    }
  }

  Widget getAddresses() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list_of_addresses.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                _currentAddress=widget.list_of_addresses[index]["address_line_1"].toString()+","+widget.list_of_addresses[index]["address_line_2"].toString();
                get_address_id=widget.list_of_addresses[index]["id"];
                print('address id to be send: '+get_address_id.toString());
                _loading=true;
                getRate();
                Navigator.of(context).pop();
              });
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(widget.list_of_addresses[index]["address_line_1"].toString()+","+widget.list_of_addresses[index]["address_line_2"].toString()),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final spinkit = SpinKitWave(
    color: Colors.lightBlue,
    size: 30,
  );
  TextEditingController promocodeText= TextEditingController();

  Future<bool> _onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartCopy()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
     onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: _loading
              ? Center(
            child: spinkit,
          ):
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 50),
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.black87,
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShoppingCartCopy()));
                        }
                      ),
                      Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Name : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rohit Ghodke',
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
                                'Alternate Phone no. : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Enter Mobile Number',
                                      fillColor: Colors.blue,
                                      border: InputBorder.none),
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Address : ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  _currentAddress.length==0?
                                    widget.list_of_addresses[widget.list_of_addresses.length-1]
                                    ["address_line_1"].toString()+","
                                        +widget.list_of_addresses[widget.list_of_addresses.length-1]
                                    ["address_line_2"].toString(): _currentAddress,
//                              maxLines: 5,
//                              overflow:TextOverflow.ellipsis,
                                ),
                              ),

                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: 30,
                                margin: EdgeInsets.only(right: 7, top: 15),
                                child: RaisedButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          title: Center(
                                              child: const Text(
                                            "All Addresses",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                                ),
                                          )),
                                          content: getAddresses(),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => GoogleMapPage()));
                                                },
                                                child: const Text(
                                                  "ADD ADDRESS",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )
                                            ),
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("CANCEL",style: TextStyle(color: Colors.red),),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0)),
                                  color: Colors.white,
                                  textColor: Colors.red,
                                  icon: Icon(
                                    Icons.location_on,
                                    size: 14,
                                  ),
                                  label: Text(
                                    'CHANGE ADDRESS',
                                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Price Details',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Subtotal:'),
                              Text(rateData["sub_total"].toString())
                            ],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text('Tax :'), Text(rateData["tax"].toString())],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text('Discount :'), Text(rateData["discount"].toString())],
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text('Delivery Charges :'), Text(rateData["delivery_charge"].toString())],
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
                                rateData["total"].toString(),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'PROMOCODE',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width/1.2,
                                  padding: EdgeInsets.only(right: 10),
                                  height: 30,
                                  child: TextFormField(
                                    controller: promocodeText,
                                    style: TextStyle(
                                      fontSize: 15
                                    ),
                                    decoration: new InputDecoration(
                                      labelText: "Enter PromoCode",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
//                                      borderRadius:
//                                          new BorderRadius.circular(8.0),
                                        borderSide: new BorderSide(),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/4,
                                height: 30,
                                child: RaisedButton(
                                  child: Text('APPLY',style: TextStyle(fontSize: 13),),
                                  onPressed: () {
                                    setState(() {
                                      _loading=true;
                                      getRate();
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(8.0)
                                     ),
                                  color: Colors.green,
                                  textColor: Colors.white,
                                ),
                              ),
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
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 54,
            child: RaisedButton(
              onPressed: () async{
                if(promocode.length>0){
                  Service.placeOrder(queryRows, get_address_id,mobile_no,promocode).then((value){
                    if(value["success"]==true){
                      razorpay_id=value["data"]["razorpay_order_id"];
                    }
                  });
                }else{
                  Service.placeOrder(queryRows, get_address_id,mobile_no).then((value){
                    if(value["success"]==true){
                      razorpay_id=value["data"]["razorpay_order_id"];

                    }
                  });
                }
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => CheckRazor(razorpay_id: razorpay_id,),
                  ),
                      (Route<dynamic> route) => false,
                );
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>RazorpayHome(razorpay_id:razorpay_id)));
              },

              color: Colors.blue,
              textColor: Colors.white,
              child: Text('PROCEED TO PAYMENT'),
            ),
          ),
        ),
      ),
    );
  }

  Future getAllItems() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();
    return queryRows;
  }

  Widget getData() {
    return FutureBuilder(
      future: getAllItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Center(
            child: Text(
              'No data found',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return Flexible(
            child: ListView.builder(
                itemCount: snapshot?.data?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  sum = sum + snapshot.data[index]["subPrice"];
//                  SubCategory subCategory = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 7,
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
                                          image: NetworkImage(snapshot
                                              .data[index]["subImageUrl"]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      boxShadow: [BoxShadow(blurRadius: 2.0)]),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 9.0),
                                      child: Text(
                                        snapshot.data[index]["subName"],
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7.0, left: 10.0),
                                      child: Text(
                                        snapshot.data[index]["subPrice"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 23.0),
                                            child: ButtonTheme(
                                              minWidth: 20.0,
                                              child: OutlineButton(
                                                child:
                                                    Icon(Icons.favorite_border),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0)),
                                              ),
                                            ),
                                          ),
                                          ButtonTheme(
                                            minWidth: 20.0,
                                            child: OutlineButton(
                                              child: Icon(Icons.delete),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0)),
//                                              onPressed: () async {
//                                                int rowAffected =
//                                                    await DatabaseHelper
//                                                        .instance
//                                                        .delete(
//                                                            snapshot.data[index]
//                                                                ["subId"],snapshot.data[index]["varId"]);
//                                                setState(() {
//                                                  getAllItems();
//                                                });
////                                           widget.valueSetter(widget.id1.subCategory[i]);
//                                              },
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
                }),
          );
        }
      },
    );
  }
}
