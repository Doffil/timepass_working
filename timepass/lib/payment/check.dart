import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/paymentFailed.dart';
import 'package:timepass/pages/paymentSuccess.dart';
import 'package:timepass/services/Service.dart';
import 'razorpay_flutter.dart';


class CheckRazor extends StatefulWidget {
  final razorpay_id,amount,order_id;

  const CheckRazor({Key key, this.razorpay_id,this.amount,this.order_id}) : super(key: key);
  @override
  _CheckRazorState createState() => _CheckRazorState();
}

class _CheckRazorState extends State<CheckRazor> {
  Razorpay _razorpay = Razorpay();
  var options;
  String userName='';
  String email = '';
  int mobile_no;
  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");

    Service.checkPaymentStatus(int.parse(widget.order_id.toString()), response.orderId).then((value){
      if(value["success"]){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SuccessPage(
                response: response,amount:widget.amount,order_id:widget.order_id
            ),
          ),
              (Route<dynamic> route) => false,
        );
      }else{
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => FailedPage(
                response: response,razorpay_id:widget.razorpay_id,order_id:widget.order_id,amount:widget.amount
            ),
          ),
              (Route<dynamic> route) => false,
        );
      }
    });
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => FailedPage(
              response: response,razorpay_id:widget.razorpay_id,order_id:widget.order_id,amount:widget.amount
            ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  getUserDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('customerName');
    email = prefs.getString('customerEmailId');
    mobile_no = prefs.getInt('customerMobileNo');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var razorpay_order_id = widget.razorpay_id;
    getUserDetails();
    options = {
      'key': "rzp_test_xIfd2l0ht4arnh", // Enter the Key ID generated from the Dashboard

      'amount': widget.amount * 100, //in the smallest currency sub-unit.
      'name': 'ShreeKakaJiMasale',
      'order_id':razorpay_order_id,
      'currency': "INR",
      'buttontext': "Pay with Razorpay",
      'description': '',
      'prefill': {
        'contact': mobile_no.toString(),
        'email': email.toString(),
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
