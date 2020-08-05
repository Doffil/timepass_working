import 'package:carousel_pro/carousel_pro.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/sqlite/db_helper.dart';

class DetailsPage extends StatefulWidget {
  final details;
  final initialVariable;
  DetailsPage({Key key, @required this.details, this.initialVariable})
      : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  var productData;
  String dropDownDefaultValue;
  List<NetworkImage> imagesList = [];
  @override
  void initState() {
    super.initState();
    productData = widget.details;
    dropDownDefaultValue = productData["product_variable"][0]["id"].toString();
    imagesList.add(NetworkImage(productData["product_image_url"]));
    for (int i = 0; i < productData["product_images"].length; i++) {
      imagesList.add(
          NetworkImage(productData["product_images"][i]["product_image_url"]));
    }

    for (int i = 0; i < productData["product_variable"].length; i++) {
      detailVariable.add(Items(productData["product_variable"][i]["id"],1.00,
          double.parse(productData["product_variable"][i]["variable_selling_price"].toString()),
          double.parse(productData["product_variable"][i]["variable_original_price"].toString()),
      productData["product_variable"][i]["product_variable_options_name"], double.parse(productData["product_variable"][i]["quantity"].toString())));
    }
    totalPrice =double.parse(productData["product_variable"][0]["variable_selling_price"].toString());
  }

  var currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children:<Widget>[
          Container(
            height:MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            child: Carousel(
              images: imagesList,
              showIndicator: true,
              dotSize: 4.0,
              dotSpacing: 15.0,
              indicatorBgPadding: 5.0,
//              borderRadius: true,
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.details["name"].toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
//              _availableSize(),
                dropdown(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                _quantity(),
                SizedBox(
                  height: 30,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.black, width: .0)),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Description : ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Divider(
                          height: 10,
                          color: Colors.black,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15, right: 18, top: 8),
                          child: Text(widget.details["description"]
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        height: 54,
        child: RaisedButton(
          onPressed: () {
            print(productData["id"].toString());
            print(detailVariable[currentIndex].id.toString());
            print('selected qty is : '+detailVariable[currentIndex].value.toString());
            print('available qty is : '+detailVariable[currentIndex].aQty.toString());
            if(detailVariable[currentIndex].aQty < detailVariable[currentIndex].value){
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
            }else{
              detailVariable[currentIndex].aQty=detailVariable[currentIndex].aQty-detailVariable[currentIndex].value;
              var check1 = DatabaseHelper
                  .instance
                  .insertProduct(
                  widget.details["id"],
                  detailVariable[currentIndex].id,
                  detailVariable[currentIndex].value,
                  detailVariable[currentIndex].vName,
                  widget.details["product_image_url"],
                  widget.details["name"],
                  detailVariable[currentIndex].sPrice,
                  detailVariable[currentIndex].aPrice,
                  detailVariable[currentIndex].aQty);
              print(check1);
              Flushbar(
                margin: EdgeInsets.all(8),
                borderRadius: 8,
                backgroundColor:
                Colors.blue,
                flushbarPosition:
                FlushbarPosition.TOP,
                message:
                "Product added to cart successfully !!!",
                duration:
                Duration(seconds: 4),
              )..show(context);
            }
          },
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('ADD TO CART'),
        ),
      ),
    );
  }

  tocart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShoppingCartCopy(),
      ),
    );
  }

  Widget _quantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'MRP: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Rs.$totalPrice',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
  double check3;
  Widget dropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(style: BorderStyle.solid, width: 0.80),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButton(
              value: dropDownDefaultValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              focusColor: Color(0xFF4E35EA),
              isExpanded: true,
              underline: Container(
                height: 0,
                color: Colors.deepPurpleAccent,
              ),
              items: widget.details["product_variable"]
                  .map<DropdownMenuItem<String>>((item) {
                return new DropdownMenuItem(
                  child: new Text(item['product_variable_options_name']),
                  value: item['id'].toString(),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  dropDownDefaultValue = newVal;
                  for (int i = 0; i < detailVariable.length; i++) {
                    if (dropDownDefaultValue ==
                        detailVariable[i].id.toString()) {
                      currentIndex = i;
                      totalPrice = detailVariable[currentIndex].sPrice *
                          detailVariable[currentIndex].value;
                    }
                  }
                  print(newVal);
                });
              },
            ),
          ),
        ),
        Row(
          children: <Widget>[
            FutureBuilder(
                future: DatabaseHelper.instance.getQuantity(productData["id"],detailVariable[currentIndex].id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    return CircularProgressIndicator();
                  } else {
                    return Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: OutlineButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            String y = productData["product_variable"]
                                [currentIndex]["quantity"];
                            double check1 = double.parse(y);
                            double check2=snapshot.data;
                            check3=check1-check2;
                            print('check3 is :'+check3.toString());
                            if (detailVariable[currentIndex].value < check3) {
                              detailVariable[currentIndex].value =
                                  detailVariable[currentIndex].value + 1;
                              totalPrice =
                                  detailVariable[currentIndex].value *
                                      detailVariable[currentIndex].sPrice;
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
                        },
                        child: Icon(Icons.add),
                      ),
                    );
                  }
                }),
            Text(
              detailVariable[currentIndex].value.toString(),
              style: TextStyle(fontSize: 18),
            ),
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: OutlineButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    if (detailVariable[currentIndex].value > 1) {
                      detailVariable[currentIndex].value =
                          detailVariable[currentIndex].value - 1;
                      totalPrice = detailVariable[currentIndex].value *
                          detailVariable[currentIndex].sPrice;
                    }
                  });
                },
                child: FaIcon(
                  FontAwesomeIcons.minus,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<Items> detailVariable = [];
  double totalPrice;
}

class Items {
  int id;
  double value;
  double sPrice;
  double aPrice;
  String vName;
  double aQty;

  Items(this.id, this.value, this.sPrice,this.aPrice,this.vName,this.aQty);
}
