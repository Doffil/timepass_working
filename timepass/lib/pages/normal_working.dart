//String _locationMessage="";
//String _currentAddress="";
//bool turnOnNotification = false;
//bool turnOnLocation = false;
//
//
//void _getCurrentLocation() async{
//  final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//  print(position);
//  var lat;
//  var long;
//  lat=position.latitude;
//  long=position.longitude;
//
//  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat,long);
//  Placemark place=placemark[0];
//  setState(() {
//    _locationMessage="${position.latitude}, ${position.longitude}";
//    _currentAddress="${place.locality}, ${place.postalCode}, ${place.country}";
//  });
//
//}
//
//
//
//
//FlatButton(
//onPressed: () {
//_getCurrentLocation();
//},
//child: Text('Get Current Location'),
//),
//Text(_locationMessage),
//CustomListTile(
//icon: Icons.location_on,
//text: "Location",
//),
//Align(
//alignment: Alignment.centerLeft,
//child: Container(
//margin: EdgeInsets.all(5.0),
//child: Text('Address : ' + _currentAddress,
//style: TextStyle(
//fontWeight: FontWeight.bold,
//fontSize: 15
//),
//),
//),
//),