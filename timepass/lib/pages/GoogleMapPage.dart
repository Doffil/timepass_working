
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/HomeDemo.dart';
//import 'package:location/location.dart';

class GoogleMapPage extends StatefulWidget {
  final customerName,customerEmailId,customerId,customerMobileNo;

  const GoogleMapPage({Key key, this.customerName, this.customerEmailId, this.customerId, this.customerMobileNo}) : super(key: key);
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController mapController;

  final myController = TextEditingController();

  Marker marker;
  String _locationMessage = "";
  String _currentAddress = "";
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  String getCurrentAddress='Pruthvi House,Plot no.3,Chankya Nagar,Ambad ITI Link Road,Nashik';
  int sum = 0;
  var first;
  var lat=0.0;
  var long=0.0;

  void _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    lat = position.latitude;
    long = position.longitude;


    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: (){
          print('Marker Tapped');
        },
        position:LatLng(lat,long)
    ));

    final coordinates = new Coordinates(
        position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    List<Placemark> placemark =
    await Geolocator().placemarkFromCoordinates(lat, long);
    Placemark place = placemark[0];

     first = addresses.first;
    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, '
        '${first.subAdminArea},${first.addressLine}, ${first.featureName},'
        '${first.thoroughfare}');

    _currentAddress ='${myController.text},${first.addressLine},${first.locality},'
        '${first.postalCode}, ${first.adminArea}';

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
//      _currentAddress =
//          "${place.locality}, ${place.postalCode}, ${place.country}";
    });
  }

  List<Marker> allMarkers =[];
  bool isMarked = false;
  @override
  void initState(){
    _getCurrentLocation();
    super.initState();
  }

  LocationResult _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      first==null?Center(child: CircularProgressIndicator(),):
      ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/2.8,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(lat,long),
                    zoom:15,
                  ),
                  markers: Set.from(allMarkers),
                  onTap: _handleTap,
                ),
              ),
              Card(
                elevation: 2.0,
                margin: EdgeInsets.all(9),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Address Details',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
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
                            'Address Line 1: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: TextField(
                              controller: myController,
                              decoration: InputDecoration(
                                  hintText: 'Enter Flat no./Building Name/city/country etc.',
                                  fillColor: Colors.blue,
                                  border: InputBorder.none),
                              keyboardType: TextInputType.text,
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
                            'Street Name: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              first.addressLine
//                              maxLines: 5,
//                              overflow:TextOverflow.ellipsis,
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
                            'Pincode: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                                first.postalCode
//                              maxLines: 5,
//                              overflow:TextOverflow.ellipsis,
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
                            'City: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                                first.locality
//                              maxLines: 5,
//                              overflow:TextOverflow.ellipsis,
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
                            'State: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                                first.adminArea
//                              maxLines: 5,
//                              overflow:TextOverflow.ellipsis,
                            ),
                          ),

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
        ],
      ),
      bottomNavigationBar:  Container(
        height: 54,
        child: RaisedButton(
          onPressed: () async{
            print(_currentAddress);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('customerAddress', _currentAddress);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeDemo(currentAddress:_currentAddress,
                      customerName: widget.customerName,customerEmailId: widget.customerEmailId,
                        customerMobile: widget.customerMobileNo,customerId: widget.customerId,)));
          },

          color: Colors.blue,
          textColor: Colors.white,
          child: Text('ADD ADDRESS'),
        ),
      ),
    );
  }

  _handleTap(LatLng tappedPoint) async {
    print(tappedPoint);
    final coordinates = new Coordinates(
        tappedPoint.latitude,tappedPoint.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    first = addresses.first;
    print(' ${first.locality}, ${first.adminArea},${first.subLocality}, '
        '${first.subAdminArea},${first.addressLine}, ${first.featureName},'
        '${first.thoroughfare}');

    _currentAddress ='${myController.text},${first.addressLine},${first.locality},'
        '${first.postalCode}, ${first.adminArea}';
    setState(() {
      allMarkers=[];
      allMarkers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition){
            print(dragEndPosition);
            isMarked = true;
          }
        )
      );

    });
  }
}
