import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:timepass/pages/LoginScreen.dart';


void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
);
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool boolValue=false;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    checkInternet();
  }

  transfer(){
    Timer(Duration(milliseconds: 3000),(){
      navigateUser();
    });
  }


  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
//        navigateUser();
        Timer(Duration( milliseconds: 6300),() {
          navigateUser(); //It will redirect  after 3 seconds
        });
      }
    } on SocketException catch (_) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Data Connection'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Oops!!!You are not connected to Internet.'),
                  Text('Please try again!'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Try Again'),
                onPressed: () {
                  checkInternet();
                },
              ),
            ],
          );
        },
      );
    }
  }

  navigateUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String studentEmail = prefs.getString('customerEmailId');
    print(studentEmail);
    boolValue = prefs.getBool('isLoggedIn')??false;
    print(boolValue);
    if(boolValue==true){
      print('sdnfasnfs');
      Navigator.pushReplacement(context, new MaterialPageRoute(
          builder: (context) => Categories()));

    }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginScreen()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width:MediaQuery.of(context).size.width,
              child: TyperAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Shree Kakaji Masale",
                  ],
                  textStyle: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w600,
                    color: Colors.blue,
                    letterSpacing: 0.6
                  ),
                  textAlign: TextAlign.center,
                  alignment: AlignmentDirectional.topStart,
                speed: Duration(milliseconds: 140),
                isRepeatingAnimation: false,// or Alignment.topLeft
              ),
            ),
          ],
        ),
    );
  }
}