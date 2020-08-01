import 'package:carousel_pro/carousel_pro.dart';
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
  List<bool> isSelected = [
    true,
    false,
    false,
    false,
  ];
  List<bool> isSelected1 = [
    true,
    false,
    false,
    false,
  ];

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
      detail_variable.add(items(
          productData["product_variable"][i]["id"],
          1.00,
          double.parse(productData["product_variable"][i]
                  ["variable_selling_price"]
              .toString())));
    }
    totalPrice =double.parse(productData["product_variable"][0]["variable_selling_price"].toString());
  }

  var current_index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
        MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          child: Container(
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
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                topRight: Radius.circular(45.0),
              ),
              color: Colors.white),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
//              _availableSize1(),
              SizedBox(
                height: 5,
              ),
              _quantity(),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
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
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        height: 54,
        child: RaisedButton(
          onPressed: () {
            var check1 = DatabaseHelper.instance.insertProductFromDetails(
                productData["id"],
                detail_variable[current_index].id,
                detail_variable[current_index].value
            );
            print(check1);
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

//  Widget _availableSize() {
//    return Center(
//      child: ToggleButtons(
//          borderRadius: BorderRadius.circular(10.0),
//          children: <Widget>[
//
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(
//                '$value1 g',
//                style: TextStyle(fontSize: 16.0),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(
//                '$value2 g',
//                style: TextStyle(fontSize: 16.0),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(
//                '$value3 g',
//                style: TextStyle(fontSize: 16.0),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Text(
//                '$value4 g',
//                style: TextStyle(fontSize: 16.0),
//              ),
//            ),
//          ],
//          isSelected: isSelected1,
//          onPressed: (int index) {
//            var k = (widget.details.subPrice);
//            assert(k is int);
//            setState(() {
//              for (int buttonIndex = 0;
//              buttonIndex < isSelected1.length;
//              buttonIndex++) {
//                if (buttonIndex == index) {
//                  isSelected1[buttonIndex] = true;
//                  indexValue = index;
//                  priceValue = k;
//                  if (index == 0) {
//                    sum = (k) * value1 * _n;
//                  }
//                  if (index == 1) {
//                    sum = (k) * value2 * _n;
//                  }
//                  if (index == 2) {
//                    sum = (k) * value3 * _n;
//                  }
//                  if (index == 3) {
//                    sum = (k) * value4 * _n;
//                  }
//                } else {
//                  isSelected1[buttonIndex] = false;
//                }
//              }
//            });
//          }),
//    );
//  }

//  String dropdowndefaultvalue=widget.initialVariable;

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
                  for (int i = 0; i < detail_variable.length; i++) {
                    if (dropDownDefaultValue ==
                        detail_variable[i].id.toString()) {
                      current_index = i;
                      totalPrice = detail_variable[current_index].sprice *
                          detail_variable[current_index].value;
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
                future: DatabaseHelper.instance.getQuantity(productData["id"],detail_variable[current_index].id),
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
                                [current_index]["quantity"];
                            double check1 = double.parse(y);
                            double check2=snapshot.data;
                            double check3=check1-check2;
                            print('check3 is :'+check3.toString());
                            if (detail_variable[current_index].value < check3) {
                              detail_variable[current_index].value =
                                  detail_variable[current_index].value + 1;
                              totalPrice =
                                  detail_variable[current_index].value *
                                      detail_variable[current_index].sprice;
                            }
                          });
                        },
                        child: Icon(Icons.add),
                      ),
                    );
                  }
                }),
            Text(
              detail_variable[current_index].value.toString(),
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
                    if (detail_variable[current_index].value > 1) {
                      detail_variable[current_index].value =
                          detail_variable[current_index].value - 1;
                      totalPrice = detail_variable[current_index].value *
                          detail_variable[current_index].sprice;
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

  List<items> detail_variable = [];
  double totalPrice;
}

class items {
  int id;
  double value;
  double sprice;

  items(this.id, this.value, this.sprice);
}
