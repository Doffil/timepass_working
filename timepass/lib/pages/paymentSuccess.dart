import 'package:flutter/material.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/OrderDetails.dart';
import 'package:timepass/payment/razorpay_flutter.dart';


class SuccessPage extends StatefulWidget {
  final PaymentSuccessResponse response;
  SuccessPage({
    @required this.response,
  });

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  Future<bool> _onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Success"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/check.png')
                  )
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                child: Text(
//                  "Your payment is successful and the response is\n OrderId: ${widget.response.orderId}\nPaymentId: ${widget.response.paymentId}\nSignature: ${widget.response.signature}",
                  "Your Payment is Successful!!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width/3,
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
                height: 18,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width/3,
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
    );
  }
}
