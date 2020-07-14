import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/Model.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:timepass/pages/DetailsPage.dart';
import 'package:timepass/pages/HomePage.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:timepass/themes/light_color.dart';
import 'package:timepass/themes/theme.dart';

class SubProduct extends StatefulWidget {
  Welcome id1;
  var len;
  final ValueSetter<SubCategory> valueSetter;
  SubProduct({Key key, @required this.id1, this.valueSetter}) : super(key: key);
  @override
  _SubProductState createState() => _SubProductState();
}

class _SubProductState extends State<SubProduct> {
  int _selectedItem = 0;
  List<SubCategory> _subproducts;
  List<SubCategory> cart = [];
  List<SubCategory> _subfilteredProducts;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String dropdownValue = '100g';

  void tapcart() {
//    print(cart.length);
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context)=> ShoppingCart(cart1:cart),
//      builder: (context) => ShoppingCart(),
//      ),
//    );
  }
  @override
  void initState() {
    setState(() {
      _subproducts = widget.id1.subCategory;
      _subfilteredProducts = _subproducts;
      _getMoreData();
    });
    super.initState();
  }
  int cartLength=0;
  _getMoreData() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cartLength = prefs.getInt('cartLength') ?? 0;
    });

  }
  @override
  Widget build(BuildContext context) {
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
                      fontWeight: FontWeight.bold),
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
                        builder: (context) => SearchList()));
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 2.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                          icon: FaIcon(FontAwesomeIcons.alignLeft),
                          color: Colors.black87,
                          onPressed: () =>
                              scaffoldKey.currentState.openDrawer(),
                        ),
                        Text(
                          widget.id1.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orangeAccent),
                      child: Stack(
                        children: <Widget>[
                          IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                            icon:
                                FaIcon(FontAwesomeIcons.shoppingBag, size: 20),
                            color: Colors.black,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShoppingCart()));
                            },
                          ),
//      list.length ==0 ? new Container() :
                          new Positioned(
                            right: 2,
                            bottom: 4,
                            child: new Stack(
                              children: <Widget>[
                                new Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.green[800]),
                                new Positioned(
                                    top: 3.0,
                                    right: 3.0,
                                    child: new Center(
                                      child: new Text(
                                        cartLength.toString(),
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
          Container(
            width: AppTheme.fullWidth(context),
            margin: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: LightColor.lightGrey.withAlpha(100),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Products",
                          hintStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 0, top: 5),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.black54)),
                    ),
                  ),
                ),
//                  _icon(Icons.filter_list, color: Colors.black54)
              ],
            ),
          ),
          Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: new ListView.builder(
                itemCount: widget.id1.subCategory.length,
//              padding: const EdgeInsets.only(top:15.0,left: 15.0,right: 15.0),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(details: widget.id1.subCategory[i]),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
//                      width: 330,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 130.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                image: DecorationImage(
                                    image: NetworkImage(widget.id1.imageUrl),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
//                                  boxShadow: [
//                                    BoxShadow(blurRadius: 2.0)
//                                  ]
                              ),
                            ),
                            Container(
                              width: 200,
                              padding: EdgeInsets.only(left: 11),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.id1.subCategory[i].subName,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.8,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      'Rs.' +
                                          (widget.id1.subCategory[i].subPrice)
                                              .toString() +
                                          '/g',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 74,
                                        height: 30,
                                        margin: EdgeInsets.only(top: 10),
                                        padding: EdgeInsets.only(left: 10),
                                        decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.orangeAccent)
                                        ),
                                        child: DropdownButton<String>(
                                          value: dropdownValue,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: TextStyle(color: Colors.deepPurple),
                                          underline: Container(
                                            height: 0,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              dropdownValue = newValue;
                                            });
                                          },
                                          items: <String>[
                                            '100g', '200g', '500g', '1kg']
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        )
                                      ),
                                      Container(
                                        height: 30,
                                        margin: EdgeInsets.only(right: 7,top: 10),
                                        child: RaisedButton.icon(
                                          onPressed: () async{
//                                            cart.add(widget.id1.subCategory[i]);
                                            int i1= await DatabaseHelper.instance.insert({
                                              DatabaseHelper.columnName : widget.id1.subCategory[i].subName,
                                              DatabaseHelper.columnSubId : widget.id1.subCategory[i].subId,
                                              DatabaseHelper.columnPrice : widget.id1.subCategory[i].subPrice,
                                              DatabaseHelper.columnQuantity : widget.id1.subCategory[i].subQuantity,
                                              DatabaseHelper.columnImageUrl : widget.id1.subCategory[i].subImageUrl,
                                            });
                                            final snackBar = SnackBar(
                                              content: Text('Yay! Item added to the cart.'),
                                              action: SnackBarAction(
                                                label: 'Undo',
                                                textColor: Colors.white,
                                                onPressed: (){},
                                              ),
                                              backgroundColor: Colors.green,
                                            );
                                            Scaffold.of(context).showSnackBar(snackBar);
                                            print('inserted id is $i1');
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0)
                                          ),
                                          color: Colors.green,
                                          textColor: Colors.white,
                                          icon: Icon(Icons.shopping_cart,size: 14,),
                                          label: Text(
                                            'ADD',
                                            style: TextStyle(
                                                fontSize: 10
                                            ),
                                          ),
                                        ),
                                      ) ,
                                    ],
                                  )

//                                      Padding(
//                                        padding: const EdgeInsets.only(top: 0),
//                                        child: Row(
//                                          children: <Widget>[
//                                            Padding(
//                                              padding: const EdgeInsets.only(right: 23.0),
//                                              child: ButtonTheme(
//                                                minWidth:20.0,
//                                                child: RaisedButton.icon(
//                                                  onPressed: (){},
//                                                  color: Colors.green,
//                                                  label: Text(
//                                                    'Buy Now',
//                                                    style: TextStyle(
//                                                      fontSize: 15
//                                                    ),
//                                                  ),
//                                                  shape: RoundedRectangleBorder(
//                                                    borderRadius: BorderRadius.circular(20)
//                                                  ),
//                                                  textColor: Colors.white,
//                                                  icon: Icon(Icons.shopping_cart,size: 15,),
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
