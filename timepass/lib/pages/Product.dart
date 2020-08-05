import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:timepass/pages/DetailsPage.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/pages/ShoppingIcon.dart';
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
  bool showCross = false;

  List<Region> _region = [];
  List<String> selectedRegion = [];
  List<int> selectedVariableIndex = [];
  bool loading = true;

  final spinKit = SpinKitWave(
    color: Colors.lightBlue,
    size: 30,
  );

  List originalProductList = new List();
  List duplicateProductList = new List();
  List<String> selectedItemValue = List<String>();
  var _controller = TextEditingController();

  List<Region> temp = [];
  String aPrice, aqty;
  String sPrice;
  String vQty;
  String vId;
  String vName;

  bool noProducts = false;
  @override
  void initState() {
    showCross = false;
    loading = true;
    super.initState();
    Service.getProducts(widget.productId).then((value) {
      if (value["success"] && value["data"].length > 0) {
        originalProductList = value["data"];
        for (int i = 0; i < originalProductList.length; i++) {
          if (originalProductList[i]["product_variable"].length > 0) {
            duplicateProductList.add(originalProductList[i]);
            selectedRegion.add(
                originalProductList[i]["product_variable"][0]["id"].toString());
            selectedVariableIndex.add(0);
          }
        }
      } else if (value["success"] && value["data"].length == 0) {
        setState(() {
          noProducts = true;
        });
      }
      setState(() {
        loading = false;
      });
    });
  }

  int cartLength = 0;

  var dropdown;
  List variables;

  bool isDataPresent(int id, int vId) {
    List presentArray = DatabaseHelper.instance.isPresent(id, vId);
    if (presentArray.length == 0) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        showCross = false;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: MyDrawer(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.alignLeft),
                      color: Colors.black87,
                      onPressed: () => scaffoldKey.currentState.openDrawer(),
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
                            color: LightColor.lightGrey.withAlpha(100),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextField(
                          controller: _controller,
                          onChanged: (string) {
                            setState(() {
                              showCross = true;
                              duplicateProductList = originalProductList
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
                              suffixIcon: showCross
                                  ? IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          duplicateProductList =
                                              originalProductList;
                                          showCross = false;
                                          _controller.clear();
                                        });
                                      },
                                    )
                                  : Icon(
                                      Icons.arrow_drop_down,
                                      size: 2,
                                    )),
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
                  : noProducts
                      ? Container(
                          margin: EdgeInsets.all(27),
                          child: Text(
                            'No products available for this sub-category!!!',
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: new ListView.builder(
                              itemCount: duplicateProductList.length,
                              itemBuilder: (context, index) {
                                _region = (originalProductList[index]
                                        ["product_variable"])
                                    .map<Region>(
                                        (item) => Region.fromJson(item))
                                    .toList();
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                            details:
                                                duplicateProductList[index],
                                            initialVariable: duplicateProductList[
                                                        index]
                                                    ["product_variable"][0][
                                                "product_variable_options_name"]),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 6, right: 6, bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    height: 130,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      duplicateProductList[
                                                              index][
                                                          "product_image_url"]),
                                                  fit: BoxFit.cover),
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0)),
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
                                                  duplicateProductList[index]
                                                      ["name"],
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.8,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        getSum(
                                                            double.parse(duplicateProductList[
                                                                            index]
                                                                        ["product_variable"]
                                                                    [
                                                                    selectedVariableIndex[
                                                                        index]][
                                                                "variable_original_price"]),
                                                            double.parse(duplicateProductList[index]
                                                                            ["product_variable"]
                                                                        [selectedVariableIndex[index]]
                                                                    ["variable_selling_price"]
                                                                .toString())),
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 0.6,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            color: Colors.grey),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 3),
                                                        child: Text(
                                                          'Rs.' +
                                                              duplicateProductList[
                                                                              index]
                                                                          [
                                                                          "product_variable"]
                                                                      [
                                                                      selectedVariableIndex[
                                                                          index]]["variable_selling_price"]
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing:
                                                                  0.6),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                        width: 76,
                                                        height: 30,
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .blue)),
                                                        child: DropdownButton<
                                                            String>(
                                                          hint: Text('Select'),
                                                          icon: Icon(Icons
                                                              .arrow_drop_down),
                                                          iconSize: 24,
                                                          isExpanded: true,
                                                          elevation: 16,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepPurple),
                                                          underline: Container(
                                                            height: 0,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          items: _region.map(
                                                              (Region map) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  map.regionId,
                                                              child: new Text(
                                                                  '${map.regionDescription}',
                                                                  style: new TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                            );
                                                          }).toList(),
                                                          onChanged: (newVal) {
                                                            selectedRegion[
                                                                index] = newVal;
                                                            setState(() {
                                                              for (int i = 0;
                                                                  i <
                                                                      duplicateProductList[index]
                                                                              [
                                                                              "product_variable"]
                                                                          .length;
                                                                  i++) {
                                                                if (selectedRegion[
                                                                        index] ==
                                                                    duplicateProductList[index]["product_variable"][i]
                                                                            [
                                                                            "id"]
                                                                        .toString()) {
                                                                  selectedVariableIndex[
                                                                      index] = i;
                                                                }
                                                              }
                                                            });
                                                          },
                                                          value: selectedRegion[
                                                              index],
                                                        )),
                                                    Container(
                                                      height: 30,
                                                      margin: EdgeInsets.only(
                                                          right: 7, top: 10),
                                                      child: RaisedButton.icon(
                                                        onPressed: () async {
                                                          count1++;
                                                          var productId;
                                                          for (int i = 0;
                                                              i < duplicateProductList[index]
                                                                          ["product_variable"].length; i++) {
                                                            if (selectedRegion[index] == duplicateProductList[index]["product_variable"][i]["id"]
                                                                    .toString()) {
                                                              vName = duplicateProductList[
                                                                          index]
                                                                      [
                                                                      "product_variable"][i]
                                                                  [
                                                                  "product_variable_options_name"];
                                                              print(
                                                                  'vname is : ' +
                                                                      vName);
                                                              vQty =
                                                                  1.toString();
                                                              if (vId == null) {
                                                                vId = duplicateProductList[index]
                                                                            [
                                                                            "product_variable"]
                                                                        [
                                                                        0]["id"]
                                                                    .toString();
                                                                print(
                                                                    'vid is:' +
                                                                        vId);
                                                              }
                                                              vId = duplicateProductList[
                                                                              index]
                                                                          [
                                                                          "product_variable"]
                                                                      [i]["id"]
                                                                  .toString();
                                                              aqty = duplicateProductList[
                                                                          index]
                                                                      [
                                                                      "product_variable"]
                                                                  [
                                                                  i]["quantity"];
                                                              sPrice = duplicateProductList[
                                                                              index]
                                                                          [
                                                                          "product_variable"][i]
                                                                      [
                                                                      "variable_selling_price"]
                                                                  .toString();
                                                              aPrice = duplicateProductList[
                                                                          index]
                                                                      [
                                                                      "product_variable"][i]
                                                                  [
                                                                  "variable_original_price"];
                                                              productId = duplicateProductList[
                                                                          index]
                                                                      [
                                                                      "product_variable"][i]
                                                                  [
                                                                  "product_id"];
                                                              break;
                                                            }
                                                          }
                                                            var check1 = await DatabaseHelper
                                                                .instance
                                                                .insertProduct(
                                                                    productId,
                                                                    int.parse(
                                                                        vId),
                                                                    double.parse(
                                                                        vQty),
                                                                    vName,
                                                                    duplicateProductList[
                                                                            index]
                                                                        [
                                                                        "product_image_url"],
                                                                    duplicateProductList[
                                                                            index]
                                                                        [
                                                                        "name"],
                                                                    double.parse(
                                                                        sPrice),
                                                                    double.parse(
                                                                        aPrice),
                                                                    double.parse(
                                                                        aqty));
                                                            print('check1 in products is :'+check1.toString());
                                                            if(check1=='no'){
                                                              Flushbar(
                                                                margin: EdgeInsets
                                                                    .all(8),
                                                                borderRadius: 8,
                                                                backgroundColor:
                                                                Colors.red,
                                                                flushbarPosition:
                                                                FlushbarPosition
                                                                    .TOP,
                                                                message:
                                                                "Product is no longer available in stock,Sorry!!!",
                                                                duration:
                                                                Duration(
                                                                    seconds:
                                                                    4),
                                                              )..show(context);
                                                            }else{
                                                              Flushbar(
                                                                margin: EdgeInsets
                                                                    .all(8),
                                                                borderRadius: 8,
                                                                backgroundColor:
                                                                Colors.green,
                                                                flushbarPosition:
                                                                FlushbarPosition
                                                                    .TOP,
                                                                message:
                                                                "Product is added to cart!!!",
                                                                duration:
                                                                Duration(
                                                                    seconds:
                                                                    4),
                                                              )..show(context);
                                                            }

                                                        },
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0)),
                                                        color: Colors.blue,
                                                        textColor: Colors.white,
                                                        icon: Icon(
                                                          Icons.shopping_cart,
                                                          size: 14,
                                                        ),
                                                        label: Text(
                                                          'ADD',
                                                          style: TextStyle(
                                                              fontSize: 10),
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
        ),
      ),
    );
  }

  String checkPrice(String s, String a) {
    return a;
  }

  String getSum(aprice, sprice) {
    if (aprice == sprice) {
      print('equal price now dont display it');
      return '';
    }
    return 'Rs.' + aprice.toString();
  }
}

class Region {
  final String regionId;
  final String regionDescription;
  final String qty;
  final int sPrice;
  final String aPrice;
  Region(
      {this.regionId,
      this.regionDescription,
      this.aPrice,
      this.qty,
      this.sPrice});
  factory Region.fromJson(Map<String, dynamic> json) {
    print(json['variable_selling_price'].runtimeType);
    return new Region(
        regionId: json['id'].toString(),
        regionDescription: json['product_variable_options_name'],
        qty: (json['quantity']),
        sPrice: json['variable_selling_price'],
        aPrice: (json['variable_original_price']));
  }
}
