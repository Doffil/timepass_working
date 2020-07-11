import 'package:flutter/material.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


import '../theme.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {

  String _locationMessage="";
  String _currentAddress="";
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  int sum=0;

  @override
  void initState() {
    super.initState();
  }
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
    return Scaffold(
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24.0,left: 5.0,bottom: 2.0),
              child: Text(
                'Check-Out',
                style: TextStyle(
                  fontSize: 30,
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            getData(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 330,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    elevation: 6.0,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Total Amount: '
                                ,style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                              ),
                              Text(
                                sum.toString(),
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: (){
                    _getCurrentLocation();
                  },
                  child: Text(
                    'Get Location',
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 330,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 6.0,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Address: '
                              ,style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                            Flexible(
                              child: Text(
                                _currentAddress,
                                style: TextStyle(
                                    fontSize: 18
                                ),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> HomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Proceed to Pay',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                  RaisedButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> ShoppingCart(),
                        ),
                      );
                    },
                    child: Text(
                      'Back to Cart',
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
  Future getAllItems() async{
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
    return queryRows;
  }

  Widget getData(){
    return FutureBuilder(
      future: getAllItems(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
          return Center(
            child: Text(
              'No data found',
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          );
        }else{
          return Flexible(
            child: ListView.builder(
                itemCount: snapshot?.data?.length ?? 0,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder:(BuildContext context,int index){
                  sum=sum+snapshot.data[index]["subPrice"];
//                  SubCategory subCategory = snapshot.data[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 330,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0)
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
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
                                          image: NetworkImage(snapshot.data[index]["subImageUrl"]),
                                          fit: BoxFit.cover
                                      ),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(blurRadius: 2.0)
                                      ]),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0,top: 9.0),
                                      child: Text(
                                        snapshot.data[index]["subName"],
                                        style: TextStyle(
                                            fontSize: 18.0
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 7.0,left: 10.0),
                                      child: Text(
                                        snapshot.data[index]["subPrice"].toString(),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0,left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(right: 23.0),
                                            child: ButtonTheme(
                                              minWidth:20.0,
                                              child: OutlineButton(
                                                child: Icon(Icons.favorite_border),
                                                shape:RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                ),
                                              ),
                                            ),
                                          ),
                                          ButtonTheme(
                                            minWidth: 20.0,
                                            child: OutlineButton(
                                              child: Icon(Icons.delete),
                                              shape:RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(6.0)
                                              ),
                                              onPressed:() async{
                                                int rowAffected = await DatabaseHelper.
                                                instance.delete(snapshot.data[index]["subId"]);
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
                }
            ),
          );
        }
      },
    );
  }
}
