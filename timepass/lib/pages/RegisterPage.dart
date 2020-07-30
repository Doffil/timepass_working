import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/GoogleMapPage.dart';
import 'package:timepass/pages/HomeDemo.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/widgets/bezierContainer.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title, this.customerMobile}) : super(key: key);
  final customerMobile;
  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var check;

  @override
  void initState() {
    super.initState();
  }


  Widget _submitButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: 300,
      child: RaisedButton(
        color: Color(0xFF4E35EA),
        onPressed: () async {
          if (_formKey.currentState.validate()){

            SharedPreferences prefs = await SharedPreferences.getInstance();
            Service.registerUser(name.text,widget.customerMobile,email.text).then((value){
//              prefs.setBool('isLoggedIn', true);

              check=value;
              print(check["success"]);
              if(check["success"]){

                prefs.setString('customerName', check["data"]["customerDetails"]["name"]);
                prefs.setString('customerEmailId', check["data"]["customerDetails"]["email"]);
                prefs.setInt('customerMobileNo', check["data"]["customerDetails"]["mobile_no"]);
                prefs.setInt('customerId', check["data"]["customerDetails"]["id"]);
                prefs.setBool('isLoggedIn', true);
                print("values assigned using shared preferences");

                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    GoogleMapPage(customerName:name.text,customerEmailId:email.text,
                    customerMobileNo:widget.customerMobile,customerId:check["data"]["customerDetails"]["id"])));

//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) =>
//                            HomeDemo(customerName:name.text,
//                              customerMobile:widget.customerMobile,
//                            customerEmailId:email.text,
//                              customerId: check["data"]["customerDetails"]["id"],)));
              }else{
                print('no user register');
              }
            });
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Text(
            'Register Now',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      'Registration Form',
      style: TextStyle(
        fontSize: 18
      )
    );
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();



  final _formKey = GlobalKey<FormState>();

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Color(0xFF4E35EA),
                      primaryColorDark: Color(0xFF4E35EA),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF4E35EA))),
                           hintText: 'Username',
                        focusColor: Color(0xFF4E35EA),
                        labelText: 'Name',

                      ),
//                      initialValue:widget.detailsUser.userName,
                      controller: name,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Color(0xFF4E35EA),
                      primaryColorDark: Color(0xFF4E35EA),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xFF4E35EA))),
                hintText: 'Email',
                        focusColor: Color(0xFF4E35EA),
                        labelText: 'Email ID'

                      ),
                      controller: email,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Color(0xFF4E35EA),
                      primaryColorDark: Color(0xFF4E35EA),
                    ),
                    child: TextFormField(
//                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF4E35EA))),
//                hintText: title,
                          focusColor: Color(0xFF4E35EA),
                        labelText: widget.customerMobile.toString()
                      ),
                      initialValue: widget.customerMobile.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
                        SizedBox(height: height * .14),
                      ],
                    ),
                  ),
                ),
//            Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ),
    );
  }

}

class StudentDetails{
  final String studentName;
  final String studentEmailId;
  final int studentPhoneNo;

  StudentDetails(this.studentName, this.studentEmailId, this.studentPhoneNo);

}