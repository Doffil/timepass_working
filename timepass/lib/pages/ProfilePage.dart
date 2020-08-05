import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/main.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/pages/OrderDetails.dart';
import 'package:timepass/widgets/custom_list_tile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  //  File _image;
//  final picker= ImagePicker();
//  Future getImage() async{
//    final image = await picker.getImage(source: ImageSource.gallery);
//    setState(() {
//      _image = File(image.path);
//    });
//  }
  bool loading=true;
  Future<bool> _onBackPressed() {
    return Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
  }
  String emailId,customerName;
  int phone;

@override
  void initState() {
  loading=true;
    super.initState();
    getData();
  }
  getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailId=prefs.getString('customerEmailId');
    customerName=prefs.getString('customerName');
    phone=prefs.getInt('customerMobileNo');
    print(customerName.toString());
    setState(() {
      loading=false;
    });
  }

  final spinkit = SpinKitWave(
    color: Colors.lightBlue,
    size: 30,
  );


  @override
  Widget build(BuildContext context) {
//
//          TextEditingController _controller = TextEditingController();
//          final myController1 = TextEditingController();
//          final myController2 = TextEditingController();
          String name="";

//       void _showDialog(){
//            showDialog(
//                context: context,
//                builder: (BuildContext context) {
//                  return AlertDialog(
//                    title: Text('Edit Profile'),
//                    content: TextField(
//                      controller: _controller,
//                    ),
//                    actions: <Widget>[
//                      FlatButton(
//                        child: Text('Update'),
//                        onPressed: () {
//                          Navigator.of(context)
//                              .pop(_controller.text.toString());
////                          Navigator.pop(context,_controller.text.toString());
//                        },
//                      ),
//                    ],
//                  );
//                }
//            ).then((value){
//              setState(() {
//                name=value;
//              });
//            });
//          }

          return WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
              key: scaffoldKey,
              drawer: MyDrawer(),
              backgroundColor: Colors.white,
              body:loading?Center(child: spinkit,):
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.alignLeft),
                              onPressed: () => scaffoldKey.currentState.openDrawer(),
                            ),
                            Text(
                              "User Profile",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,

                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
//
//                            CircleAvatar(
//                              radius: 55,
//                              child: CircleAvatar(
//                                radius: 50,
//                                backgroundImage: _image==null ?AssetImage("assets/images/profileuser.png")
//                                    :FileImage(_image),
//                              ),
//                            ),

                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.solidUserCircle,color: Colors.blue,),
                              iconSize: 120,
                              onPressed: (){},
                            ),

//                            SafeArea(
//                              child: ButtonTheme(
//                                height: 40,
//                                minWidth: 30,
//                                child: RaisedButton.icon(
//                                  textColor: Colors.white,
//                                  color: Colors.redAccent,
//                                  onPressed: (){
//                                      getImage();
//                                  },
//                                  icon:Icon(Icons.edit),
//                                  label:Text(
//                                    'Change Picture',
//                                    style: TextStyle(
//                                        fontSize: 18
//                                    ),
//                                  ),
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(8.0)
//                                  ),
//                                ),
//
//                              ),
//                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                        'Name: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      customerName.toString(),
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 25,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Email: '
                                    ,style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    Text(
                                      emailId.toString(),
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  height: 25,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Phone no.: '
                                      ,style: TextStyle(
                                        fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                    Text(
                                      phone.toString(),
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                InkWell(
                                  child: CustomListTile(
                                    icon: Icons.check_circle,
                                    text: "View Orders",
                                  ),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails()));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: ButtonTheme(
                            height: 40,
                            child: RaisedButton.icon(
                              textColor: Colors.white,
                              color: Colors.blue,
                                onPressed: () {
//                                _showDialog();
                                  Flushbar(
                                    margin: EdgeInsets.all(8),
                                    borderRadius: 8,
                                    backgroundColor: Colors.green,
                                    flushbarPosition: FlushbarPosition.TOP,
                                    message: "Coming Soon!!!",
                                    duration: Duration(seconds: 4),
                                  )..show(context);
                                },
                                icon:Icon(Icons.edit),
                                label:Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontSize: 18
                                  ),
                                ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Card(
                          elevation: 3.0,
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    onTap: (){
                                      Flushbar(
                                        margin: EdgeInsets.all(8),
                                        borderRadius: 8,
                                        backgroundColor: Colors.green,
                                        flushbarPosition: FlushbarPosition.TOP,
                                        message: "Coming Soon!!!",
                                        duration: Duration(seconds: 4),
                                      )..show(context);
                                    },
                                    child: Text(
                                        "Language",
                                        style: TextStyle(
                                            fontSize: 18.0
                                        )
                                    ),
                                  ),
                                  // SizedBox(height: 10.0,),
                                  Divider(
                                    height: 25.0,
                                    color: Colors.grey,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Flushbar(
                                        margin: EdgeInsets.all(8),
                                        borderRadius: 8,
                                        backgroundColor: Colors.green,
                                        flushbarPosition: FlushbarPosition.TOP,
                                        message: "Coming Soon!!!",
                                        duration: Duration(seconds: 4),
                                      )..show(context);
                                    },
                                    child: Text(
                                        "Support",
                                        style: TextStyle(
                                            fontSize: 18.0
                                        )
                                    ),
                                  ),
                                  // SizedBox(height: 10.0,),
                                  Divider(
                                    height: 25.0,
                                    color: Colors.grey,
                                  ),
                                   InkWell(
                                     onTap: ()async{
                                       SharedPreferences prefs = await SharedPreferences.getInstance();
                                       FirebaseAuth.instance.signOut();
                                       prefs.setString('customerName', null);
                                       prefs.setString('customerEmailId', null);
                                       prefs.setString('customerId', null);
                                       prefs.setBool("isLoggedIn", false);
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                                     },
                                     child: Text('Sign Out',
                                        style: TextStyle(
                                            fontSize: 18.0)
                                        ,),
                                   ),
                                  // SizedBox(height: 10.0,),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
}