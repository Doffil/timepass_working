import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:timepass/main.dart';
import 'package:timepass/pages/DetailsPage.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:timepass/themes/light_color.dart';
import 'package:timepass/themes/theme.dart';

class Product extends StatefulWidget {
  final productId;
  final subCategoryName;
  Product({Key key, this.productId, this.subCategoryName}) : super(key: key);
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  int count1 = 0;
  var products;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String _myState;

  List<Region> _region = [];
  List<String> selectedRegion=[];
  List<int> selectedVariableIndex=[];

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
  List original_product_list=new List();
  List duplicate_product_list=new List();
  List<String> selectedItemValue = List<String>();
  var _controller = TextEditingController();

  List<Region> temp=[];
  String aprice,aqty;
  String sprice;
  String vqty;
  String vid;
  String vname;

  @override
  void initState() {
    super.initState();
    Service.getProducts(widget.productId).then((value){
//      products = value;
    if(value["success"] && value["data"].length > 0){
      original_product_list = value["data"];
      for(int i=0;i<original_product_list.length;i++){
        if(original_product_list[i]["product_variable"].length > 0){
          duplicate_product_list.add(original_product_list[i]);
          selectedRegion.add(original_product_list[i]["product_variable"][0]["id"].toString());
          selectedVariableIndex.add(0);
//          _region=(original_product_list[i]["product_variable"]).map<Region>((item) => Region.fromJson(item)).toList();
        }
      }
//      for(int i=0;i<_region.length ;i++){
//        print(_region[i].regionid);
//        print(_region[i].regionDescription);
//      }
    }
    setState(() {

    });
    });
//    setState(() {
//      _subproducts = widget.id1.subCategory;
//      _subfilteredProducts = _subproducts;
//      _getMoreData();
//    });
  }

  int cartLength = 0;
  _getMoreData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cartLength = prefs.getInt('cartLength');
    });
  }

  var dropdown;
  List variables;

  bool isDataPresent(int id,int vId) {
    List presentArray =
    DatabaseHelper.instance.isPresent(id,vId);
    if (presentArray.length == 0) {
      return false;
    }
    return true;
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => products()));
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.shoppingBag),
              title: Text('Shopping-Cart'),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType
                            .rightToLeft,
                        duration:
                        Duration(milliseconds: 500),
                        child: ShoppingCartCopy()));
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.userCircle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
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
              onTap: ()async {
                //add at the last
                await DatabaseHelper.instance.deleteAll();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                FirebaseAuth.instance.signOut();
                prefs.setString('customerName', null);
                prefs.setString('customerEmailId', null);
                prefs.setString('customerId', null);
                prefs.setBool("isLoggedIn", false);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
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
                          widget.subCategoryName.toString(),
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
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeft,
                                      duration:
                                      Duration(milliseconds: 500),
                                      child: ShoppingCartCopy()));
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
                      controller: _controller,
                      onChanged: (string) {
                        setState(() {
                          duplicate_product_list = original_product_list
                              .where((u) => (u["name"]
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                              .toList();
                        });
                        if (string.length == null) {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Products",
                          hintStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.only(
                              left: 10, right: 10, bottom: 0, top: 5),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.black54),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: (){
                              setState(() {
                                duplicate_product_list=original_product_list;
                                _controller.clear();
                              });
                            },
                          )

                      ),
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

                      itemCount: duplicate_product_list.length,
//              padding: const EdgeInsets.only(top:15.0,left: 15.0,right: 15.0),
                      itemBuilder: (context, index) {
                        _region = (original_product_list[index]["product_variable"]).map<Region>((item) => Region.fromJson(item)).toList();
//                        selectedRegion[index]= _region[0].regionid;
//                        variables = products[index]["product_variable"];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailsPage(details: duplicate_product_list[index],
                                        initialVariable:duplicate_product_list[index]["product_variable"][0]["product_variable_options_name"]),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 6, right: 6, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            height:130,
//                      width: 330,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width/3,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                          image: NetworkImage(duplicate_product_list[index]
                                              ["product_image_url"]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0)),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.only(left: 11),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          duplicate_product_list[index]["name"],
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.8,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                getSum(double.parse(duplicate_product_list[index]["product_variable"][selectedVariableIndex[index]]["variable_original_price"]),
                                                 double.parse(duplicate_product_list[index]["product_variable"][selectedVariableIndex[index]]["variable_selling_price"].toString())),
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.6,
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Colors.grey
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 3),
                                                child: Text(
                                                  'Rs.'+duplicate_product_list[index]["product_variable"][selectedVariableIndex[index]]["variable_selling_price"].toString(),
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 0.6
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                                width: 74,
                                                height: 30,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                        color: Colors
                                                            .orangeAccent)),
                                                child: DropdownButton<String>(
                                                  hint: Text('Select'),
                                                  icon: Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 24,
//                                                  hint: Text('select'),
                                                  isExpanded: true,
                                                  elevation: 16,
                                                  style: TextStyle(
                                                      color: Colors.deepPurple),
                                                  underline: Container(
                                                    height: 0,
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                  items: _region.map((Region map) {
//                                                    print(map.regionid);
//                                                    print(map.regionDescription);

                                                    return new DropdownMenuItem<String>(
                                                      value: map.regionid,
                                                      child: new Text('${map.regionDescription}',
                                                          style: new TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newVal) {
                                                    selectedRegion[index]=newVal;
                                                    setState(() {
                                                      for(int i=0;i<duplicate_product_list[index]["product_variable"].length; i++){
                                                        if(selectedRegion[index]==duplicate_product_list[index]["product_variable"][i]["id"].toString()){
                                                          selectedVariableIndex[index]=i;
                                                        }
                                                      }
                                                    });
//                                                    print(selectedRegion[index]);
                                                  },
                                                  value: selectedRegion[index],
                                                )),
                                            Container(
                                              height: 30,
                                              margin: EdgeInsets.only(
                                                  right: 7, top: 10),
                                              child: RaisedButton.icon(
                                                onPressed: () async {
//                                                cart.add(widget.id1.subCategory[i]);
                                                    count1++;
                                                    var productId;
//                                                    if(vid==null){
//                                                      vid= duplicate_product_list[index]["product_variable"][0]["id"].toString();
//                                                      print('vid is:'+vid);
//                                                    }
//                                                      print('second vid is'+vid);
                                                    for(int i=0;i<duplicate_product_list[index]["product_variable"].length;i++){
                                                      if(selectedRegion[index]==duplicate_product_list[index]["product_variable"][i]["id"].toString()){
                                                        vname = duplicate_product_list[index]["product_variable"][i]["product_variable_options_name"];
                                                        print('vname is : '+vname);
                                                        vqty= 1.toString(); if(vid==null){
                                                      vid= duplicate_product_list[index]["product_variable"][0]["id"].toString();
                                                      print('vid is:'+vid);
                                                    }
                                                        vid= duplicate_product_list[index]["product_variable"][i]["id"].toString();
                                                        aqty = duplicate_product_list[index]["product_variable"][i]["quantity"];
                                                        sprice=duplicate_product_list[index]["product_variable"][i]["variable_selling_price"].toString();
                                                        aprice = duplicate_product_list[index]["product_variable"][i]["variable_original_price"];
                                                        productId= duplicate_product_list[index]["product_variable"][i]["product_id"];
                                                        break;
                                                      }
                                                    }

                                                    var check1=DatabaseHelper.instance.insertProduct(productId, int.parse(vid),double.parse(vqty), vname, duplicate_product_list[index]["product_image_url"],
                                                        duplicate_product_list[index]["name"], double.parse(sprice), double.parse(aprice),double.parse(aqty));
                                                      print(check1);
//                                                    int i1= await DatabaseHelper.instance.insert({
//                                                      DatabaseHelper.name : duplicate_product_list[index]["name"],
//                                                      DatabaseHelper.productId : duplicate_product_list[index]["id"],
//                                                      DatabaseHelper.sPrice :sprice,
//                                                      DatabaseHelper.quantity :vqty,
//                                                      DatabaseHelper.imageUrl :duplicate_product_list[index]["product_image_url"],
//                                                      DatabaseHelper.aPrice :aprice,
//                                                      DatabaseHelper.varId :vid,
//                                                      DatabaseHelper.vName :vname,
//                                                    });
//                                                    final snackBar = SnackBar(
//                                                      content: Text('Yay! Item added to the cart.'),
//                                                      action: SnackBarAction(
//                                                        label: 'Undo',
//                                                        textColor: Colors.white,
//                                                        onPressed: (){},
//                                                      ),
//                                                      backgroundColor: Colors.green,
//                                                    );
//                                                    Scaffold.of(context).showSnackBar(snackBar);
//                                                    print('inserted id is $i1');
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                color: Colors.green,
                                                textColor: Colors.white,
                                                icon: Icon(
                                                  Icons.shopping_cart,
                                                  size: 14,
                                                ),
                                                label: Text(
                                                  'ADD',
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
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
                )

        ],
      ),
    );
  }

  getAllProducts(){
    Service.getProducts(widget.productId).then((value){
//      print(value);
    });
  }

  String checkPrice(String s,String a) {
    return a;
  }

  String getSum(aprice, sprice) {
    if(aprice==sprice){
      print('equal price now dont display it');
      return '';
    }
    return 'Rs.'+aprice.toString();
  }
}



class Region {
  final String regionid;
  final String regionDescription;
  final String qty;
  final int sprice;
  final String aprice;
  Region({this.regionid, this.regionDescription,this.aprice,this.qty,this.sprice});
  factory Region.fromJson(Map<String, dynamic> json) {
    print(json['variable_selling_price'].runtimeType);
    return new Region(
        regionid: json['id'].toString(), regionDescription: json['product_variable_options_name'],
      qty: (json['quantity']),sprice: json['variable_selling_price'],
        aprice:(json['variable_original_price']));

  }
}