import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/pages/ShoppingIcon.dart';
import 'package:timepass/pages/SubCategories.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/themes/light_color.dart';
import 'package:timepass/themes/theme.dart';
import 'package:page_transition/page_transition.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var categories;

  var _controller = TextEditingController();

  bool loading = true;
  bool showCross = false;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  final spinKit = SpinKitWave(
    color: Colors.lightBlue,
    size: 30,
  );

  List originalCategoriesList = new List();
  List duplicateCategoriesList = new List();

  @override
  void initState() {
    showCross = false;
    super.initState();
    loading = true;
    Service.getCategories().then((value) {
      setState(() {
        if (value["success"] && value["data"].length > 0) {
          originalCategoriesList = value["data"];
          duplicateCategoriesList = originalCategoriesList;
        }
        loading = false;
      });
    });
  }

  int cartLength = 0;

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              title: const Text(
                "Are you Sure?",
              ),
              content: const Text("Do you want to exit the app?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text(
                      "YES",
                      style: TextStyle(color: Colors.red),
                    )),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("NO"),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              setState(() {
                showCross=false;
              });
            },
            child: Scaffold(
                key: scaffoldKey,
                drawer:MyDrawer(),
                body: SafeArea(
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: FaIcon(
                                              FontAwesomeIcons.alignLeft),
                                          color: Colors.black87,
                                          onPressed: () => scaffoldKey
                                              .currentState
                                              .openDrawer(),
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
                                   ShoppingIcon(),
                                  ]),
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
                                            color: LightColor.lightGrey
                                                .withAlpha(100),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: TextField(
                                          controller: _controller,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Search Products",
                                              hintStyle: TextStyle(fontSize: 12),
                                              contentPadding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 0,
                                                  top: 5),
                                              prefixIcon: Icon(Icons.search,
                                                  color: Colors.black54),
                                              suffixIcon: showCross
                                                  ? IconButton(
                                                      icon: Icon(Icons.clear),
                                                      onPressed: () {
                                                        setState(() {
                                                          duplicateCategoriesList =
                                                              originalCategoriesList;
                                                          showCross = false;
                                                          _controller.clear();
                                                        });
                                                      },
                                                    )
                                                  : Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 2,
                                                    )),
                                          onChanged: (string) {
                                            setState(() {
                                              showCross = true;
                                              duplicateCategoriesList =
                                                  originalCategoriesList
                                                      .where((u) =>
                                                          (u["product_category_name"]
                                                              .toLowerCase()
                                                              .contains(string
                                                                  .toLowerCase())))
                                                      .toList();
                                            });
                                            if (string.length == null) {
                                              FocusScope.of(context).unfocus();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              loading
                                  ? Center(
                                      child: spinKit,
                                    )
                                  :duplicateCategoriesList.length == 0
                                  ? Center(
                                child: Text(
                                  'No categories found !!!',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )
                                  :
                              Expanded(
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: new GridView.builder(
                                          itemCount:
                                              duplicateCategoriesList.length,
                                          itemBuilder: (context, index) {
                                            if(duplicateCategoriesList[index]
                                            ["product_sub_category"].length > 0 && duplicateCategoriesList[
                                            index]
                                            ["is_active"] ==
                                                1 ){
                                              return Card(
                                                  margin: EdgeInsets.fromLTRB(
                                                      7, 7, 10, 10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                  ),
                                                  elevation: 3.0,
                                                  child: Container(
                                                      child: InkWell(
                                                        splashColor: Colors.orange,
                                                        onTap: () {
                                                          print(
                                                              duplicateCategoriesList[
                                                              index]["id"]
                                                                  .toString());
                                                          if (duplicateCategoriesList[
                                                          index]
                                                          ["is_active"] ==
                                                              1 &&
                                                              duplicateCategoriesList[
                                                              index][
                                                              "product_sub_category"]
                                                                  .length >
                                                                  0) {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => SubCategories(
                                                                    categoryName:
                                                                    duplicateCategoriesList[
                                                                    index][
                                                                    "product_category_name"],
                                                                    subCategories:
                                                                    duplicateCategoriesList[
                                                                    index][
                                                                    "product_sub_category"]),
                                                              ),
                                                            );
                                                          } else {
                                                            Flushbar(
                                                              margin: EdgeInsets.all(8),
                                                              borderRadius: 8,
                                                              backgroundColor:
                                                              Colors.red,
                                                              flushbarPosition:
                                                              FlushbarPosition.TOP,
                                                              message:
                                                              "There are no subcategories for this category,Sorry!!!",
                                                              duration:
                                                              Duration(seconds: 4),
                                                            )..show(context);
                                                          }
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                        10.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                        10.0)),
                                                                child:
                                                                CachedNetworkImage(
                                                                  imageUrl:
                                                                  duplicateCategoriesList[
                                                                  index][
                                                                  "product_category_image_url"],
                                                                  placeholder:
                                                                      (context, url) {
                                                                    return Icon(Icons
                                                                        .shopping_cart);
                                                                  },
                                                                  fit: BoxFit.fill,
                                                                  height: 130,
                                                                  width: 220,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 5.0,
                                                                  bottom: 5.0,
                                                                  left: 9.0),
                                                              child: Opacity(
                                                                opacity: 0.8,
                                                                child: Text(
                                                                  duplicateCategoriesList[
                                                                  index][
                                                                  "product_category_name"],
                                                                  softWrap: true,
                                                                  style: TextStyle(
                                                                      fontSize: 15.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                      letterSpacing:
                                                                      0.5),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(
                                                                  left: 9.0,
                                                                  bottom: 6.0),
                                                              child: Text(
                                                                '('+duplicateCategoriesList[index]
                                                                ["product_sub_category"].length.toString()+')',
                                                                style: TextStyle(
                                                                  fontSize: 12.0,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )));
                                            }
                                            return Text('');
                                          },
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                          ),
                                        ),
                                      ),
                                    )
                            ]),
                ))));
  }
}
