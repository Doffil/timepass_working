import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/pages/CheckOutPage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:timepass/pages/GoogleMapPage.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/services/Service.dart';
import 'package:timepass/sqlite/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingCartCopy extends StatefulWidget {
  @override
  _ShoppingCartCopyState createState() => _ShoppingCartCopyState();
}

class _ShoppingCartCopyState extends State<ShoppingCartCopy> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPresent = true;
  int count1 = 0;

  void initState() {
    super.initState();
  }

  noItemsInCart() {
    return Expanded(
      child: Center(
        child: Text('No items in cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer:MyDrawer(),
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.alignLeft),
                          color: Colors.black87,
                          onPressed: () =>
                              scaffoldKey.currentState.openDrawer(),
                        ),
                        Text(
                          'Shopping-Cart',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.trash,
                            color: Colors.red, size: 18),
                        color: Colors.black,
                        onPressed: () async {
                          await DatabaseHelper.instance.deleteAll();
                          setState(() {
                            getAllItems();
                          });
                        },
                      ),
                    ),
                  ]),
              getData(),
            ]),
      ),
      bottomNavigationBar: FutureBuilder(
        future: DatabaseHelper.instance.getTotalPrice(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          } else {
            return Container(
              height: 54,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Rs. ${snapshot.data}',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      int mobileNo = prefs.getInt('customerMobileNo');

                      Service.getAddress(mobileNo).then((value) {
                        if (value["success"] == false && snapshot.data > 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoogleMapPage()));
                        } else if (snapshot.data > 0 &&
                            value["success"] == true) {
                          int mobileNo = prefs.getInt('customerMobileNo');
                          print('mobile no in checkout page is:' +
                              mobileNo.toString());

                          if (value["success"] && value["data"].length != 0) {
                            listOfAddresses = value["data"];
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckOutPage(
                                        listOfAddresses: listOfAddresses)));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GoogleMapPage()));
                          }
                        } else {
                          Flushbar(
                            margin: EdgeInsets.all(8),
                            borderRadius: 8,
                            backgroundColor: Colors.red,
                            flushbarPosition: FlushbarPosition.TOP,
                            message: "Please add item to cart to proceed!!!",
                            duration: Duration(seconds: 2),
                          )..show(context);
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Place Order',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future getAllItems() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('cartLength', queryRows.length);
    print(queryRows.length);
    return queryRows;
  }

  List listOfAddresses = new List();

  Widget getData() {
    return FutureBuilder(
      future: DatabaseHelper.instance.queryAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data.length == 0) {
          return Align(
              alignment: Alignment.center,
              heightFactor:20,
              child: Text(
                'No products in shopping-cart !!!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ));
        } else {
          return Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: snapshot?.data?.length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.horizontal,
                      background: Container(
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      onDismissed: (direction) async {
                        int rowAffected = await DatabaseHelper.instance
                            .delete(snapshot.data[index]["_id"]);
                        print('we have deleted '+rowAffected.toString());
                        setState(() {
                          getAllItems();
                        });
                      },
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              title: const Text(
                                "Confirm",
                              ),
                              content: const Text(
                                  "Are you sure you wish to delete this item?"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      int rowAffected = await DatabaseHelper
                                          .instance
                                          .delete(snapshot.data[index]
                                              ["productVariableId"]);
                                      if (rowAffected > 0) {
                                        print('we have deleted');
                                      } else {
                                        print('not deleted');
                                      }
                                      setState(() {
                                        getAllItems();
                                      });
                                      Navigator.of(context).pop(true);
                                      Flushbar(
                                        margin: EdgeInsets.all(8),
                                        borderRadius: 8,
                                        backgroundColor: Colors.red,
                                        flushbarPosition: FlushbarPosition.TOP,
                                        message:
                                            "You have successfully removed the item from cart!!!",
                                        duration: Duration(seconds: 2),
                                      )..show(context);
                                    },
                                    child: const Text(
                                      "DELETE",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                FlatButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("CANCEL"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: GestureDetector(
                        onTap: () {},
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 5, bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 2,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data[index]["productImageUrl"]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  snapshot.data[index]
                                                          ["productName"] +
                                                      ' (' +
                                                      snapshot.data[index]
                                                          ["productVName"] +
                                                      ')',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 42),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 27,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () async {
                                                  int rowAffected =
                                                      await DatabaseHelper
                                                          .instance
                                                          .delete(snapshot
                                                                  .data[index][
                                                              "productVariableId"]);
                                                  if (rowAffected > 0) {
                                                    print('we have deleted');
                                                  } else {
                                                    print('not deleted');
                                                  }

                                                  print('rowaffected' +
                                                      rowAffected.toString());
                                                  setState(() {
                                                    getAllItems();
                                                  });

//                                                      Navigator.of(context).pop(true);
                                                  Flushbar(
                                                    margin: EdgeInsets.all(8),
                                                    borderRadius: 8,
                                                    backgroundColor: Colors.red,
                                                    flushbarPosition:
                                                        FlushbarPosition.TOP,
                                                    message:
                                                        "You have successfully removed the item from cart!!!",
                                                    duration:
                                                        Duration(seconds: 2),
                                                  )..show(context);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6),
                                          child: Text(
                                            getSum1(
                                                snapshot.data[index]
                                                    ["productQuantity"],
                                                snapshot.data[index]
                                                    ["productSPrice"]),
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, right: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                getSum(
                                                    snapshot.data[index]
                                                        ["productQuantity"],
                                                    snapshot.data[index]
                                                        ["productSPrice"],
                                                    snapshot.data[index]
                                                        ["productAPrice"]),
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.8,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 34,
                                                      height: 34,
                                                      child: OutlineButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .plus,
                                                            size: 10,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (snapshot.data[index]["productQuantity"] <
                                                                  snapshot.data[index]["productAvailableQuantity"]) {
                                                                var check1 = DatabaseHelper.instance.insertProductInCart(
                                                                    snapshot.data[index]["productId"],
                                                                    snapshot.data[index]["productVariableId"],
                                                                    snapshot.data[index]["productQuantity"]);
                                                                sum = snapshot.data[index]["productQuantity"] *
                                                                    snapshot.data[index]["productAPrice"];
                                                                print(check1);
                                                              }else{
                                                                Flushbar(
                                                                  margin: EdgeInsets.all(8),
                                                                  borderRadius: 8,
                                                                  backgroundColor:
                                                                  Colors.red,
                                                                  flushbarPosition:
                                                                  FlushbarPosition.TOP,
                                                                  message:
                                                                  "Product is no longer available in Stock,Sorry!!!",
                                                                  duration:
                                                                  Duration(seconds: 4),
                                                                )..show(context);
                                                              }
                                                            });
                                                          }),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Text(
                                                        snapshot.data[index][
                                                                "productQuantity"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 34,
                                                      height: 34,
                                                      child: OutlineButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            size: 10,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.0)),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (snapshot.data[
                                                                          index]
                                                                      [
                                                                      "productQuantity"] >
                                                                  1) {
                                                                var check1 = DatabaseHelper.instance.minusProductInCart(
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        "productId"],
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        "productVariableId"],
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        "productQuantity"]);
                                                                sum = snapshot.data[
                                                                            index]
                                                                        [
                                                                        "productQuantity"] *
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        "productAPrice"];
                                                                print(check1);
                                                              }
                                                            });
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
      },
    );
  }

  double sum = 0;
  var totalPrice = DatabaseHelper.instance.getTotalPrice();

  String getSum(qty, sPrice, aPrice) {
    sum = 0;
    sum = qty * aPrice;
    if (sPrice == aPrice) {
      return '';
    }
    return 'Rs.' + sum.toString();
  }

  String getSum1(qty, sprice) {
    sum = 0;
    sum = qty * sprice;
    return 'Rs.' + sum.toString();
  }
}
