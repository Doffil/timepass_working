import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/Model.dart';
import 'package:timepass/pages/SubProduct.dart';
import 'package:timepass/pages/SubProductScreen.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/theme.dart';

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
      margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
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

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubProductScreen(id2:model)));
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
                      height: 142,
                      width: 240,
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
  bool _loading;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loading = true;
    Service.getProducts().then((products) {
      setState(() {
        _products = products;
        _filteredProducts = _products;
        _loading = false;
      });
    });
  }

  _getMoreData(){
    print('more data needed');
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
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
//      backgroundColor: Color(0xF6F5F5),
//    backgroundColor: Colors.black12,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:EdgeInsets.only(top: 50.0, left: 0.0, bottom: 2.0),
              child: Row(
                children: <Widget>[
                  IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                  icon: FaIcon(FontAwesomeIcons.alignLeft),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 30,
                      color: MyColors.primaryColor,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 1.0, left: 9, right: 9, bottom: 10),
              child: Container(
                height: 40,
                color: Colors.white70,
                margin: EdgeInsets.all(7),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Search the product',
                  ),
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
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: new GridView.builder(
                    controller: _scrollController,
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
