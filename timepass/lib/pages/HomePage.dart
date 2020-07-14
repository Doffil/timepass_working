import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/Model.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/pages/SubCategories.dart';
import 'package:timepass/pages/SubProduct.dart';
import 'package:timepass/pages/SubProductScreen.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/themes/light_color.dart';
import 'package:timepass/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GridItem extends StatelessWidget {
  GridItem(this.model);

  @required
  final Welcome model;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(7, 7, 10, 10),
      elevation: 3.0,
      child: Container(
          alignment: Alignment.center,
          child: InkWell(
            splashColor: Colors.orange,
            onTap: () {
              print(this.model.id);
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SubProduct(id1: model),
//                ),
//              );

               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SubCategories()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: ClipRRect(
//                  borderRadius: BorderRadius.circular(10.0),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/shopping.jpeg',
                      image: this.model.imageUrl,
                      fit: BoxFit.fill,
                      height: 130,
                      width: 220,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 9.0),
                  child: Opacity(
                    opacity: 0.8,
                    child: Text(
                      this.model.name,
                      softWrap: true,
//                        textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, bottom: 6.0),
                  child: Text(
                    '(40)',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<Welcome> _products;
  List<Welcome> _filteredProducts;
  bool _loading=true;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final spinkit = SpinKitWave(
    color: Colors.lightBlue,
    size: 30,
  );

//
//  @override
//  void initState() {
//    super.initState();
//    _loading = true;
//    Service.getProducts().then((products) {
//      setState(() {
//        _products = products;
//        _filteredProducts = _products;
//        _loading = false;
//        _getMoreData();
//      });
//    });
//  }


  @override
  void initState() {
     Service.getProducts().then((products) {
      setState(() {
        _products = products;
        _filteredProducts = _products;
        _loading = false;
        _getMoreData();
      });
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
//      backgroundColor: Color(0xF6F5F5),
//    backgroundColor: Colors.black12,
        body:_loading?Center(child: spinkit,):
        Column(
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
                            'Categories',
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
                              icon: FaIcon(FontAwesomeIcons.shoppingBag,
                                  size: 20),
                              color: Colors.black,
                              onPressed: () =>{
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => ShoppingCart()))
                              }

                            ),
//      list.length ==0 ? new Container() :
                            new Positioned(
                              right: 2,
                              bottom: 4,
                              child: new Stack(
                                children: <Widget>[
                                  new Icon(Icons.brightness_1,
                                      size: 21.0, color: Colors.green[800]),
                                  new Positioned(
                                      top: 2.0,
                                      right: 6.2,
                                      bottom: 1,
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
//            Padding(
//              padding: const EdgeInsets.only(
//                  top: 1.0, left: 9, right: 9, bottom: 10),
//              child: Container(
//                height: 40,
//                color: LightColor.lightGrey.withAlpha(100),
//                margin: EdgeInsets.all(7),
//                child: TextField(
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.only(left: 15),
//                    border: OutlineInputBorder(
//                      borderRadius: BorderRadius.circular(40.0),
//                    ),
//                    suffixIcon: Icon(Icons.search),
//                    hintText: 'Search the product',
//                  ),
//                  onChanged: (string) {
//                    setState(() {
//                      _filteredProducts = _products
//                          .where((u) => (u.name
//                              .toLowerCase()
//                              .contains(string.toLowerCase())))
//                          .toList();
//                    });
//                    if (string.length == null) {
//                      FocusScope.of(context).unfocus();
//                    }
//                  },
//                ),
//              ),
//            ),
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
                        onChanged: (string) {
                          setState(() {
                            _filteredProducts = _products
                                .where((u) => (u.name
                                    .toLowerCase()
                                    .contains(string.toLowerCase())))
                                .toList();
                          });
                          if (string.length == null) {
                            FocusScope.of(context).unfocus();
                          }
                        },
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: new GridView.builder(
                    itemCount: null == _filteredProducts
                        ? 0
                        : _filteredProducts.length,
                    itemBuilder: (context, index) {
//                Welcome product= _filteredProducts[index];
                      return GridItem(_filteredProducts[index]);
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
