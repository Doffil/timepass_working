import 'package:flutter/material.dart';
import 'package:timepass/payment/check.dart';


class RazorpayHome extends StatefulWidget {
  final razorpay_id;

  const RazorpayHome({Key key, this.razorpay_id}) : super(key: key);
  @override
  _RazorpayHomeState createState() => _RazorpayHomeState();
}

class _RazorpayHomeState extends State<RazorpayHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Integration"),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            color: Colors.green,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => CheckRazor(),
                  ),
                  (Route<dynamic> route) => false,
                ),
            child: Text(
              "Pay Now",
            ),
          ),
        ),
      ),
    );
  }
}
