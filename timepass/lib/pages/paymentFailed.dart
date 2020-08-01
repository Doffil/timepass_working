import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/shopping-copy.dart';


class FailedPage extends StatefulWidget {
  final response;
  FailedPage({
    @required this.response,
  });

  @override
  _FailedPageState createState() => _FailedPageState();
}

class _FailedPageState extends State<FailedPage> {

  Future<bool> _onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onBackPressed ,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment Success"),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/cross.png')
                      )
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
//                "Your payment is Failed and the response is\n Code: ${response.code}\nMessage: ${response.message}",
                  "Your payment is Failed!!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 30,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            8.0)),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShoppingCartCopy()));
                    },
                    child: Text(
                      'Retry payment',
                      style:
                      TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 30,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            8.0)),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
                    },
                    child: Text(
                      'Go to Home',
                      style:
                      TextStyle(fontSize: 10),
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
