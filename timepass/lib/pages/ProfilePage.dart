import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/stores/login_store.dart';
import 'package:timepass/widgets/custom_list_tile.dart';
import 'package:timepass/widgets/small_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  var scaffoldKey = GlobalKey<ScaffoldState>();
  File _image;
  final picker= ImagePicker();
  Future getImage() async{
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
//    return Consumer<LoginStore>(
//        builder: (_, loginStore, __) {
          TextEditingController _controller = TextEditingController();
          final myController1 = TextEditingController();
          final myController2 = TextEditingController();
          String name="";

       void _showDialog(){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Edit Profile'),
                    content: TextField(
                      controller: _controller,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Update'),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(_controller.text.toString());
//                          Navigator.pop(context,_controller.text.toString());
                        },
                      ),
                    ],
                  );
                }
            ).then((value){
              setState(() {
                name=value;
              });
            });
          }

          return Scaffold(
            key: scaffoldKey,
            drawer: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: DrawerHeader(
                      child: Text(
                        'Grocery',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categories()));
                    },
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.shoppingBag),
                    title: Text('Shopping-Cart'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShoppingCart()));
                    },
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.userCircle),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfilePage()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Language'),
                    onTap: () {
                      //yet to implement
                    },
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.signOutAlt),
                    title: Text('Sign-Out'),
                    onTap: () {
                      //add at the last
                    },
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 40.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
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
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                        Container(
//                          height: 130.0,
//                          width: 120.0,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(90.0),
//                            boxShadow: [
//                              BoxShadow(
//                                  blurRadius: 3.0,
//                                  offset: Offset(0, 4.0),
//                                  color: Colors.black38),
//                            ]),
//                              child:_image==null?Image.asset("assets/images/profileuser.png")
//                                  :Image.file(_image)
//                        ),

                        CircleAvatar(
                          radius: 55,
//                          backgroundColor: Color(0xffFDCF09),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _image==null ?AssetImage("assets/images/profileuser.png")
                                :FileImage(_image),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 50,left: 12),
                          child: ButtonTheme(
                            height: 40,
                            minWidth: 30,
                            child: RaisedButton.icon(
                              textColor: Colors.white,
                              color: Colors.redAccent,
                              onPressed: (){
                                  getImage();
                              },
                              icon:Icon(Icons.edit),
                              label:Text(
                                'Change Picture',
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
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
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
                                  name,
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
                                  'ghodke',
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
                                  'Alternate Phone no.: '
                                  ,style: TextStyle(
                                    fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                                Text(
                                  '9762434445',
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
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            CustomListTile(
                              icon: Icons.check_circle,
                              text: "View Orders",
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
                          color: Colors.blueAccent,
                            onPressed: () {
                            _showDialog();
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
                    Text(name),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Other Functionalities",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      elevation: 3.0,
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
                              Text(
                                  "Language",
                                  style: TextStyle(
                                      fontSize: 18.0
                                  )
                              ),
                              // SizedBox(height: 10.0,),
                              Divider(
                                height: 25.0,
                                color: Colors.grey,
                              ),
                               Text('Sign Out',
                                  style: TextStyle(
                                      fontSize: 18.0)
                                  ,),
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
          );
        }
}