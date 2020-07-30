import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/main.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/LoginScreen.dart';

class HomeDemo extends StatelessWidget {

  final FirebaseUser user;
  final customerName,customerEmailId,customerMobile,customerId,currentAddress;

  HomeDemo({this.user, this.customerName, this.customerEmailId, this.customerMobile,
    this.customerId,this.currentAddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("You are Logged in succesfully", style: TextStyle(color: Colors.lightBlue, fontSize: 32),),
            SizedBox(height: 16,),
            Text(customerMobile.toString(), style: TextStyle(color: Colors.grey, ),),
            SizedBox(height: 16,),
            Text(customerName.toString(), style: TextStyle(color: Colors.grey, ),),
            SizedBox(height: 16,),
            Text(customerEmailId.toString(), style: TextStyle(color: Colors.grey, ),),
            SizedBox(height: 16,),
            Text(customerId.toString(), style: TextStyle(color: Colors.grey, ),),
            SizedBox(height: 16,),
            Text(currentAddress.toString(), style: TextStyle(color: Colors.grey, ),),
            SizedBox(height: 16,),

            RaisedButton(
              child: Text(
                'LogOut'
              ),
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                FirebaseAuth.instance.signOut();
                prefs.setString('customerName', null);
                prefs.setString('customerEmailId', null);
                prefs.setString('customerId', null);
                prefs.setBool("isLoggedIn", false);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
              },
            ),
            SizedBox(height: 16,),

            RaisedButton(
              child: Text(
                  'Home'
              ),
              onPressed: () async{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
              },
            )
          ],
        ),
      ),
    );
  }
}