import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/GoogleMapPage.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/payment/check.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CheckOutPage extends StatefulWidget {
  final String currentAddress;
  final listOfAddresses;
  const CheckOutPage({Key key, this.currentAddress, this.listOfAddresses}) : super(key: key);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

  String _currentAddress;
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  int sum = 0;
  int getAddressId;
  var rateData;
  bool _loading=true;
  String promoCode="";
  List queryRows=[];
  int mobileNo;
  String customerName;
  var razorpayId;
  var orderId;
  bool checkOutLoader=false;
  TextEditingController alternatePhoneNo = TextEditingController();
  String altNo="";
  @override
  void initState() {
    print('loaded');
    _loading=true;
    _currentAddress=widget.listOfAddresses[widget.listOfAddresses.length-1]
    ["address_line_1"].toString()+","
        +widget.listOfAddresses[widget.listOfAddresses.length-1]
        ["address_line_2"].toString();
    getAddressId=widget.listOfAddresses[widget.listOfAddresses.length-1]["id"];
    getRate();
    super.initState();
  }

  getRate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNo=prefs.getInt('customerMobileNo');
    customerName = prefs.getString('customerName');
    queryRows=await DatabaseHelper.instance.queryAll();
    if(queryRows.length!=0){
      promoCode=promoCodeText.text;
      if(promoCode.length>0){
        Service.getRates(queryRows, getAddressId, mobileNo,promoCode).then((value){
          if(value["success"]==true){
            rateData=value["data"];
            setState(() {
              _loading=false;
            });
            if(rateData["discount"]==0){
              Flushbar(
                margin: EdgeInsets.all(8),
                borderRadius: 8,
                backgroundColor:
                Colors.red,
                flushbarPosition:
                FlushbarPosition.TOP,
                message:
                "Wrong Promocode,Sorry!!!",
                duration:
                Duration(seconds: 4),
              )..show(context);
            }
            print('discount is:'+rateData["discount"].toString());
          }
        });
      }else{
        Service.getRates(queryRows, getAddressId, mobileNo).then((value){
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
        itemCount: widget.listOfAddresses.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                _currentAddress=widget.listOfAddresses[index]["address_line_1"].toString()+","+widget.listOfAddresses[index]["address_line_2"].toString();
                getAddressId=widget.listOfAddresses[index]["id"];
                print('address id to be send: '+getAddressId.toString());
                _loading=true;
                getRate();
                Navigator.of(context).pop();
              });
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(widget.listOfAddresses[index]["address_line_1"].toString()+","+widget.listOfAddresses[index]["address_line_2"].toString()),
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
  TextEditingController promoCodeText= TextEditingController();

  Future<bool> onBackPressed() {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShoppingCartCopy()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child:
      LoadingOverlay(
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
                                customerName.toString(),
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
                                child: TextFormField(
                                  controller: alternatePhoneNo,
                                  validator: (value) {
                                    String patttern = '^[6-9]{1}[0-9]{9}';
                                    RegExp regExp = new RegExp(patttern);
                                    if(!regExp.hasMatch(value)){
                                      return 'Please enter valid mobile number';
                                    }else if(value.length==0){
                                      return 'Please enter mobile Number';
                                    }
                                    return null;
                                  },
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
                                    widget.listOfAddresses[widget.listOfAddresses.length-1]
                                    ["address_line_1"].toString()+","
                                        +widget.listOfAddresses[widget.listOfAddresses.length-1]
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
                                  height: 36,
                                  child: TextFormField(
                                    controller: promoCodeText,
                                    style: TextStyle(
                                      fontSize: 15
                                    ),
                                    decoration: new InputDecoration(
                                      labelText: "Enter PromoCode",
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
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
                                height: 35,
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
          bottomNavigationBar: _loading
              ? Center(
            child: spinkit,
          ):
          Container(
            height: 54,
            child: RaisedButton(
              onPressed: () async{
                setState(() {
                  _loading=true;
                });
                altNo=alternatePhoneNo.text;
                if(promoCode.length>0){
                  Service.placeOrder(queryRows, getAddressId,mobileNo,promocode:promoCode, alternateMobileNo:altNo).then((value){
                    if(value["success"]==true){
                      razorpayId=value["data"]["razorpay_order_id"];
                      orderId=value["data"]["order_id"];
                      print('order id in checkout is '+orderId.toString());
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => CheckRazor(razorpay_id: razorpayId,
                              amount:rateData["total"],order_id:orderId),
                        ),
                            (Route<dynamic> route) => false,
                      );
                    }
                  });
                }else{
                  Service.placeOrder(queryRows, getAddressId,mobileNo, alternateMobileNo:altNo).then((value){
                    if(value["success"]==true){
                      razorpayId=value["data"]["razorpay_order_id"];
                      orderId=value["data"]["order_id"].toString();
                      print('order id in checkout is '+orderId.toString());
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => CheckRazor(razorpay_id: razorpayId,amount:rateData["total"],order_id:orderId),
                        ),
                            (Route<dynamic> route) => false,
                      );
                    }
                  });
                }
              },

              color: Colors.blue,
              textColor: Colors.white,
              child: Text('PROCEED TO PAYMENT'),
            ),
          ),
        ),
        opacity: 0.5,
        isLoading: checkOutLoader,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }

  Future getAllItems() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();
    return queryRows;
  }

}
