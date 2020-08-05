import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/HomeDemo.dart';
import 'package:http/http.dart' as http;
import 'package:timepass/pages/RegisterPage.dart';
import 'package:timepass/services/Service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  var isNewUser;
  bool alreadyRegistered=false;

  checkUser(String phone,BuildContext context,int mobile)async{

  }

  Future<bool> loginUser(String phone, BuildContext context,int mobile) async{

    FirebaseAuth _auth = FirebaseAuth.instance;
      setState(() {
        isLoading=true;
      });
      _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(seconds: 110),
          verificationCompleted: (AuthCredential credential) async{
            Navigator.of(context).pop();

            AuthResult result = await _auth.signInWithCredential(credential);
            print('verify phone number:'+mobile.toString());
            FirebaseUser user = result.user;
            print('user in main function is :'+user.toString());

            if(user!=null){
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Service.checkUser(mobile).then((value){
                setState(() {
                  isLoading=false;
                });
                isNewUser=value;
                if(isNewUser["success"]==true){
                  print('is user registered : '+isNewUser["data"]["userExist"].toString());

                  if(isNewUser["data"]["userExist"]==true){
                    var customerName,customerEmailId;
                    var mobile_no;
                    customerName = isNewUser["data"]["userDetails"]["name"];
                    customerEmailId = isNewUser["data"]["userDetails"]["email"];
                    mobile_no = isNewUser["data"]["userDetails"]["mobile_no"];
                    prefs.setString('customerName',customerName);
                    prefs.setString('customerEmailId', customerEmailId);
                    prefs.setInt('customerMobileNo',int.parse( mobile_no));
                    prefs.setBool('isLoggedIn', true);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
                  }else{
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            RegisterPage(customerMobile: mobile,)
                    ));
                  }
                }else{
                  print('sorry something went wrong');
                }
              });
            }else{
              print('error in logging/no otp is checked');
            }
          },
          verificationFailed: (AuthException exception){
            setState(() {
              isLoading=false;
            });
            Flushbar(
              margin: EdgeInsets.all(8),
              borderRadius: 8,
              backgroundColor:
              Colors.red,
              flushbarPosition:
              FlushbarPosition.TOP,
              message:
              "Your number is not accepted in firebase,Sorry!!!",
              duration:
              Duration(seconds: 4),
            )..show(context);
            print(exception);
          },
          codeSent: (String verificationId, [int forceResendingToken]){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Give the code?"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _codeController,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Resend"),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () async{
                        },
                      ),
                      FlatButton(
                        child: Text("Confirm"),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () async{
                          setState(() {
                            isLoading=true;
                          });
                          final code = _codeController.text.trim();
                          AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                          AuthResult result = await _auth.signInWithCredential(credential);
                          FirebaseUser user = result.user;
                          print('user in dialog box is :'+user.toString());
                          if(user != null) {

                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            Service.checkUser(mobile).then((value){
                              setState(() {
                                isLoading=false;
                              });
                              isNewUser=value;
                              if(isNewUser["success"]==true){
                                print('is user registered : '+isNewUser["data"]["userExist"].toString());

                                if(isNewUser["data"]["userExist"]==true){
                                  var customerName,customerEmailId;
                                  var mobile_no;
                                  customerName = isNewUser["data"]["userDetails"]["name"];
                                  customerEmailId = isNewUser["data"]["userDetails"]["email"];
                                  mobile_no = isNewUser["data"]["userDetails"]["mobile_no"];
                                  prefs.setString('customerName',customerName);
                                  prefs.setString('customerEmailId', customerEmailId);
                                  prefs.setInt('customerMobileNo',int.parse( mobile_no));
                                  prefs.setBool('isLoggedIn', true);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
                                }else{
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterPage(customerMobile: mobile,)
                                  ));
                                }
                              }else{
                                print('sorry something went wrong');
                              }
                            });
                          }
                        },
                      )
                    ],
                  );
                }
            );
          },
          codeAutoRetrievalTimeout: null
      );

  }


Future<bool> _onBackPressed() {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        title: const Text(
          "Are you Sure?",
        ),
        content: const Text("Do you want to exit the app?"),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                exit(0);
              },
              child: const Text(
                "YES",
                style: TextStyle(color: Colors.red),
              )),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("NO"),
          ),
        ],
      );
    },
  ) ??
      false;
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            body: LoadingOverlay(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
//                  Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                        SizedBox(height: 18,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/loginfinal.png')
                              )
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[200])
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(color: Colors.grey[300])
                              ),
                              filled: true,
                              prefixIcon: Icon(Icons.call),
                              fillColor: Colors.grey[100],
                              hintText: "Enter Mobile Number",
                            labelText: 'Mobile No.'

                          ),
                          controller: _phoneController,
                          validator: (value) {
                            String patttern = '^[6-9]{1}[0-9]{9}';
                            RegExp regExp = new RegExp(patttern);
                            if(!regExp.hasMatch(value)){
                              return 'Please enter valid mobile number';
                            }else if(value.length==0){
                              return 'Please enter mobile Number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),

                        SizedBox(height: 18,),


                        Container(
                          width: double.infinity,
                          child: FlatButton(
                            child: Text("LOGIN"),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(16),
                            onPressed: () {
                              final phone = _phoneController.text.trim();
                              final mobile = "+91"+phone.toString();
                              loginUser(mobile,context,int.parse(phone));
                            },
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              isLoading:isLoading,
              opacity: 0.5,
              progressIndicator: CircularProgressIndicator(),
            )
        ),
      ),
    );
  }
}