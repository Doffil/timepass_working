import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:timepass/stores/login_store.dart';
import 'package:timepass/widgets/custom_list_tile.dart';
import 'package:timepass/widgets/small_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _locationMessage="";
  String _currentAddress="";
  bool turnOnNotification = false;
  bool turnOnLocation = false;


  void _getCurrentLocation() async{
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    var lat;
    var long;
    lat=position.latitude;
    long=position.longitude;

    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat,long);
    Placemark place=placemark[0];
    setState(() {
      _locationMessage="${position.latitude}, ${position.longitude}";
      _currentAddress="${place.locality}, ${place.postalCode}, ${place.country}";
      });

  }



  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
        builder: (_, loginStore, __) {
          final myController = TextEditingController();
          final myController1 = TextEditingController();
          final myController2 = TextEditingController();
          String name = "Rohit",
              mobile = "9384034";

//
//    @override
//    void dispose() {
//      // Clean up the controller when the widget is disposed.
//      myController.dispose();
//      myController1.dispose();
//      myController2.dispose();
//      super.dispose();
//    }

          void _showDialog() {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Edit Profile'),
                    content: TextField(
                      controller: myController,
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text('Update'),
                        onPressed: () {
                          setState(() {
                            name = myController.text;
                            mobile = myController2.text;
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],

                  );
                }
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 120.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3.0,
                                  offset: Offset(0, 4.0),
                                  color: Colors.black38),
                            ],
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/profileuser.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(name),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              myController2.text,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            OutlineButton(
                                child: Text('Edit'),
                                onPressed: () {
                                  _showDialog();
                                }
                            )
//                      SmallButton(btnText: "Edit",),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Account",
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
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {
                                _getCurrentLocation();
                              },
                              child: Text('Get Current Location'),
                            ),
                            Text(_locationMessage),
                            CustomListTile(
                              icon: Icons.location_on,
                              text: "Location",
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: Text('Address : ' + _currentAddress,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            CustomListTile(
                              icon: Icons.shopping_cart,
                              text: "Shipping",
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            CustomListTile(
                              icon: Icons.check_circle,
                              text: "View Orders",
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Notifications",
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
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "App Notification",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Switch(
                                  value: turnOnNotification,
                                  onChanged: (bool value) {
                                    // print("The value: $value");
                                    setState(() {
                                      turnOnNotification = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Location Tracking",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Switch(
                                  value: turnOnLocation,
                                  onChanged: (bool value) {
                                    // print("The value: $value");
                                    setState(() {
                                      turnOnLocation = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Other",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Card(
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
                                  "Language", style: TextStyle(fontSize: 16.0)),
                              // SizedBox(height: 10.0,),
                              Divider(
                                height: 30.0,
                                color: Colors.grey,
                              ),
                              FlatButton(
                                onPressed: () {
                                  loginStore.signOut(context);
                                },
                                child: Text('Sign Out',style: TextStyle(fontSize: 18.0),),
                              ),
                              // SizedBox(height: 10.0,),
                              Divider(
                                height: 30.0,
                                color: Colors.grey,
                              ),
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
        });
  }
}