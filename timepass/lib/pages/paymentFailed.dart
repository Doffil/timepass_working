import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/payment/check.dart';
import 'package:timepass/themes/light_color.dart';
import 'package:timepass/themes/theme.dart';


class FailedPage extends StatefulWidget {
  final response,razorpay_id,order_id,amount;
  FailedPage({
    @required this.response, this.razorpay_id,this.order_id,this.amount
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
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                  Container(
//                    width: MediaQuery.of(context).size.width,
//                    height: MediaQuery.of(context).size.height/3,
//                    decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: AssetImage('assets/images/cross.png'),
//                        )
//                    ),
//                  ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.timesCircle,color:LightColor.red,),
                  iconSize: 120,
                ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
//                "Your payment is Failed and the response is\n Code: ${response.code}\nMessage: ${response.message}",
                    "Your payment is Failed!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
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
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => CheckRazor(razorpay_id: widget.razorpay_id,
                                amount:widget.amount,order_id:widget.order_id),
                          ),
                              (Route<dynamic> route) => false,
                        );                      },
                      child: Text(
                        'Retry payment',
                        style:
                        TextStyle(fontSize: 18),
                      ),
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
                        TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
