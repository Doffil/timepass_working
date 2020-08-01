import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/widgets/bezierContainer.dart';

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
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
//        color: Color(0xFF4E35EA),
      color: Colors.blue,
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
                    Categories()));

              }else{
                print('no user register');
              }
            });
          }
        },
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(30),
//        ),
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
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.blue
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
                      primaryColor: Colors.blue,
                      primaryColorDark: Colors.blue,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue)),
                           hintText: 'Username',
                        focusColor: Colors.blue,
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
                      primaryColor: Colors.blue,
                      primaryColorDark: Colors.blue,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue)),
                hintText: 'Email',
                        focusColor: Colors.blue,
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
                      primaryColor: Colors.blue,
                      primaryColorDark: Colors.blue,
                    ),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue)),
//                hintText: title,
                          focusColor: Colors.blue,
                        labelText: 'Mobile No.',
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
//                Positioned(
//                  top: -MediaQuery.of(context).size.height * .15,
//                  right: -MediaQuery.of(context).size.width * .4,
//                  child: BezierContainer(),
//                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/registerfinal.png')
                              )
                          ),
                        ),
                        SizedBox(height:10),
                        _title(),
                        SizedBox(
                          height: 20,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
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