import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/HomeDemo.dart';
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
    transfer();
  }

  transfer(){
    Timer(Duration(seconds: 5),(){
      navigateUser();
    });
  }


  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
//        navigateUser();
        Timer(Duration( seconds: 3),() {
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
    setState(() {
      print('googd');
    });
    if(boolValue==true && studentEmail!=null && studentEmail.length>2){
//      String customerName=prefs.getString('customerName');
//      String customerEmailId=prefs.getString('customerEmailId');
//      int customerPhoneNo=prefs.getInt('customerPhoneNo');
//      int customerId=prefs.getInt('customerId');
//      String customerAddress = prefs.getString('customerAddress');
//      print(customerAddress);
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
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splashscreen.png"),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}