import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/OrderDetails.dart';
import 'package:timepass/payment/razorpay_flutter.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:timepass/themes/light_color.dart';


class SuccessPage extends StatefulWidget {
  final PaymentSuccessResponse response;
  final amount,order_id;
  SuccessPage({
    @required this.response,this.amount,this.order_id
  });

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  Future<bool> _onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
  }
  bool loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clearCart();
  }
  clearCart()async{
    await DatabaseHelper.instance.deleteAll();
    setState(() {
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          body: loading?Center(child: CircularProgressIndicator(),):
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.checkCircle,color:Colors.green,),
                  iconSize: 120,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
//                  "Your payment is successful and the response is\n OrderId: ${widget.response.orderId}\nPaymentId: ${widget.response.paymentId}\nSignature: ${widget.response.signature}",
                        'Your Payment of '+widget.amount.toString()+' is Successful!!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Your order id is : '+widget.order_id.toString()
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            8.0)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
                    },
                    child: Text(
                      'Go to Home',
                      style:
                      TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            8.0)),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails()));
                    },
                    child: Text(
                      'View Orders',
                      style:
                      TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
