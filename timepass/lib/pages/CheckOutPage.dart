import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/pages/GoogleMapPage.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/pages/RegisterPage.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:geocoder/geocoder.dart';
import 'package:timepass/widgets/custom_list_tile.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String _locationMessage = "";
  String _currentAddress = "";
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  String getCurrentAddress='Pruthvi House,Plot no.3,Chankya Nagar,Ambad ITI Link Road,Nashik';
  int sum = 0;
   List<String> list_of_addresses = <String>[
    ' 1st Flr, 190, Haroon Bldg, Shamaldas Gandhim Marg, Princess Street, Mumbai-400002,Maharashtra',
    'Unit No B/6, Grd Floor, Sussex Indl Est, Dadoji Kondeo Cross Marg, Bangalore-560053,Maharashtra',
    'Sadani Dhabi, Narol Vatva Road, Nr Sonia Hospital, Vatva,Ahmedabad-382445,Gujarat',
    'Pruthvi House,Plot no.3,Chankya Nagar,Ambad ITI Link Road,Nashik',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    var lat;
    var long;
    lat = position.latitude;
    long = position.longitude;
    final coordinates = new Coordinates(
        position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    List<Placemark> placemark =
        await Geolocator().placemarkFromCoordinates(lat, long);
    Placemark place = placemark[0];

    var first = addresses.first;
    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, '
        '${first.subAdminArea},${first.addressLine}, ${first.featureName},'
        '${first.thoroughfare}');

    _currentAddress ='${first.locality}, ${first.adminArea},${first.subLocality}, '
    '${first.subAdminArea},${first.addressLine}, ${first.featureName},'
    '${first.thoroughfare}, ${first.subThoroughfare}';

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
//      _currentAddress =
//          "${place.locality}, ${place.postalCode}, ${place.country}";
    });
  }
//
//  ${place.locality}, ${place.adminArea},${place.subLocality},
//${place.subAdminArea},${place.addressLine}, ${place.featureName},
//${place.thoroughfare}, ${place.subThoroughfare}

  Widget getAddresses() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list_of_addresses.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                getCurrentAddress= list_of_addresses[index];
                _currentAddress="";
                Navigator.of(context).pop();
              });
            },
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(list_of_addresses[index]),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50),
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black87,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShoppingCart()));
                      }
                    ),
                    Text(
                      "Check Out",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Name : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rohit Ghodke',
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
                              'Alternate Phone no. : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter Mobile Number',
                                    fillColor: Colors.blue,
                                    border: InputBorder.none),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 14
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Address : ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Text(
                                  _currentAddress.length==0?
                                  getCurrentAddress : _currentAddress
//                              maxLines: 5,
//                              overflow:TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.gps_fixed),
                              onPressed: (){
                                _getCurrentLocation();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 7, top: 15),
                              child: RaisedButton.icon(
                                onPressed: () {
                                 Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoogleMapPage()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                color: Colors.green,
                                textColor: Colors.white,
                                icon: Icon(
                                  Icons.add_location,
                                  size: 14,
                                ),
                                label: Text(
                                  'ADD ADDRESS',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),

                            Container(
                              height: 30,
                              margin: EdgeInsets.only(right: 7, top: 15),
                              child: RaisedButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        title: Center(
                                            child: const Text(
                                          "All Addresses",
                                        )),
                                        content: getAddresses(),
                                        actions: <Widget>[
                                          FlatButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "SELECT",
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )),
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text("CANCEL",style: TextStyle(color: Colors.red),),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                color: Colors.green,
                                textColor: Colors.white,
                                icon: Icon(
                                  Icons.location_on,
                                  size: 14,
                                ),
                                label: Text(
                                  'CHANGE ADDRESS',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Price Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Item Price :'),
                            Text('Rs.100')
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Text('SGST(5%) :'), Text('Rs.10')],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Text('CGST(5%) :'), Text('Rs.10')],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total Amount :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Rs.120',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'PROMOCODE',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: 150,
                                height: 30,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                  decoration: new InputDecoration(
                                    labelText: "Enter PromoCode",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
//                                      borderRadius:
//                                          new BorderRadius.circular(8.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              child: RaisedButton(
                                child: Text('APPLY PROMOCODE',style: TextStyle(fontSize: 10),),
                                onPressed: () {

                                },
                                shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(8.0)
                                   ),
                                color: Colors.green,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total Price :',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              'Rs.120',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Final Amount :',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Rs.100',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: RaisedButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('PROCEED TO PAYMENT'),
        ),
      ),
    );
  }

  Future getAllItems() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();
    return queryRows;
  }

  Widget getData() {
    return FutureBuilder(
      future: getAllItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Center(
            child: Text(
              'No data found',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return Flexible(
            child: ListView.builder(
                itemCount: snapshot?.data?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  sum = sum + snapshot.data[index]["subPrice"];
//                  SubCategory subCategory = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(left: 18, right: 18, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 7,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data[index]["subImageUrl"]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      boxShadow: [BoxShadow(blurRadius: 2.0)]),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10.0, top: 9.0),
                                      child: Text(
                                        snapshot.data[index]["subName"],
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7.0, left: 10.0),
                                      child: Text(
                                        snapshot.data[index]["subPrice"]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 23.0),
                                            child: ButtonTheme(
                                              minWidth: 20.0,
                                              child: OutlineButton(
                                                child:
                                                    Icon(Icons.favorite_border),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0)),
                                              ),
                                            ),
                                          ),
                                          ButtonTheme(
                                            minWidth: 20.0,
                                            child: OutlineButton(
                                              child: Icon(Icons.delete),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0)),
                                              onPressed: () async {
                                                int rowAffected =
                                                    await DatabaseHelper
                                                        .instance
                                                        .delete(
                                                            snapshot.data[index]
                                                                ["subId"]);
                                                setState(() {
                                                  getAllItems();
                                                });
//                                           widget.valueSetter(widget.id1.subCategory[i]);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        }
      },
    );
  }
}
