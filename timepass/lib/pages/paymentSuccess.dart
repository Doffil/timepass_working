import 'package:flutter/material.dart';
import 'package:timepass/pages/Categories.dart';
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
      onWillPop:_onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Success"),
        ),
        body: Center(
          child: Container(
            child: Text(
              "Your payment is successful and the response is\n OrderId: ${widget.response.orderId}\nPaymentId: ${widget.response.paymentId}\nSignature: ${widget.response.signature}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
