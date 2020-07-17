import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  List<Marker> myMarker =[];
  bool isMarked = false;
  @override
  void initState(){
    super.initState();
  }

  LocationResult _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('location picker'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(20.5937,78.9629),
            zoom: 4,
          ),
          markers: Set.from(myMarker),
          mapType: MapType.hybrid,
          onTap: _handleTap,
        ),
      ),
    );
  }

  _handleTap(LatLng tappedPoint){
    print(tappedPoint);
    setState(() {
      myMarker=[];
      myMarker.add(
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
