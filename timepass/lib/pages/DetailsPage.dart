////import 'package:carousel_pro/carousel_pro.dart';
////import 'package:flutter/material.dart';
////import 'package:flutter/rendering.dart';
////import 'package:timepass/Model.dart';
////import 'package:timepass/pages/ShoppingCart.dart';
////
////class DetailsPage extends StatefulWidget {
////  final details;
////  DetailsPage({Key key, @required this.details}) :super(key: key);
////  @override
////  _DetailsPageState createState() => _DetailsPageState();
////}
////
////class _DetailsPageState extends State<DetailsPage> {
////  List<bool>isSelected = [true, false, false,false];
////  List<SubCategory>cart=[];
////  final heroTag = "assets/images/vegetables.jpeg";
////
////  @override
////  Widget build(BuildContext context) {
////    return Scaffold(
//////      backgroundColor: Color(0xFF7A9BEE),
////      body: Stack(
////        children: <Widget>[
////          Container(
////              height: MediaQuery
////                  .of(context)
////                  .size
////                  .height,
////              width: MediaQuery
////                  .of(context)
////                  .size
////                  .width,
////              color: Colors.transparent
////          ),
////          Positioned(
////            child:Hero(
////                  tag: heroTag,
////                  child: Container(
////                    height: 250.0,
////                    width: 400.0,
////                    child: Carousel(
////                      images: [
////                        AssetImage(heroTag),
////                        AssetImage("assets/images/shopping.jpeg"),
////                        AssetImage(heroTag),
////                      ],
////                      showIndicator: false,
////                    ),
////                  )
////              )
////          ),
////          Positioned(
////            top: 200.0,
////            child: Container(
////              decoration: BoxDecoration(
////                  borderRadius: BorderRadius.only(
////                    topLeft: Radius.circular(45.0),
////                    topRight: Radius.circular(45.0),
////                  ),
////                  color: Colors.white),
////              height: MediaQuery
////                  .of(context)
////                  .size
////                  .height,
////              width: MediaQuery
////                  .of(context)
////                  .size
////                  .width,
////              child: Column(
////                mainAxisAlignment: MainAxisAlignment.start,
////                crossAxisAlignment: CrossAxisAlignment.start,
////                children: <Widget>[
////                  Padding(
////                    padding: const EdgeInsets.all(20.0),
////                    child: Row(
////                      crossAxisAlignment: CrossAxisAlignment.start,
////                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      children: <Widget>[
////                        Text(
////                          widget.details.subName,
////                          style: TextStyle(
////                              fontSize: 30.0
////                          ),
////                        ),
////                        Text(
////                          'Rs.'+widget.details.subPrice+'/g',
////                          style: TextStyle(
////                              fontSize: 30.0
////                          ),
////                        ),
////
////                      ],
////
////                    ),
////                  ),
////                  SizedBox(height: 10,),
////                  _availableSize(),
////                  SizedBox(height: 20,),
////                  _quantity(),
////                  SizedBox(height: 20,),
////                  Padding(
////                    padding: const EdgeInsets.all(10.0),
////                    child: Text(
////                      'Total Price : Rs.$sum',
////                      style: TextStyle(
////                          fontSize: 25.0
////                      ),
////                    ),
////                  ),
////                  SizedBox(height: 20,),
////                  Padding(
////                    padding: const EdgeInsets.all(10.0),
////                    child: Text(
////                      'Description : ',
////                      style: TextStyle(
////                          fontSize: 25.0
////                      ),
////                    ),
////                  ),
////                  SizedBox(height: 20,),
////                  Row(
////                    mainAxisAlignment: MainAxisAlignment.start,
////                    children: <Widget>[
////                      Padding(
////                        padding: const EdgeInsets.only(right: 23.0,left: 20.0),
////                        child: ButtonTheme(
////                          minWidth:20.0,
////                          height: 45,
////                          child: OutlineButton(
////                            child: Icon(Icons.favorite_border),
////                            shape:RoundedRectangleBorder(
////                                borderRadius: BorderRadius.circular(6.0)
////                            ),
////                          ),
////                        ),
////                      ),
////                      Padding(
////                        padding: EdgeInsets.all(8.0),
////                        child:ButtonTheme(
////                          height: 45,
////                          child: RaisedButton.icon(
////                            onPressed: (){
////                              cart.add(widget.details);
////                            },
////                            shape: RoundedRectangleBorder(
////                                borderRadius: BorderRadius.circular(8.0)
////                            ),
////                            color: Colors.green,
////                            textColor: Colors.white,
////                            icon: Icon(Icons.shopping_cart),
////                            label: Text(
////                                'ADD TO CART',
////                              style: TextStyle(
////                                fontSize: 16
////                              ),
////                            ),
////                          ),
////                        ) ,
////                      ),
////                    ],
////                  )
////
////                ],
////              ),
////            ),
////          )
////        ],
////      ),
////      floatingActionButton:FloatingActionButton(
////        child: Icon(Icons.shopping_cart),
////        onPressed: tocart,
////      ),
////    );
////  }
////
////  tocart(){
////    Navigator.push(
////      context,
////      MaterialPageRoute(
////        builder: (context)=>ShoppingCart(cart1: cart),
//////      builder: (context)=>ShoppingCart(),
////      ),
////    );
////  }
////
////  var sum = 10000;
////  var _n=0;
////  var value1=500,value2=750,value3=1000,value4=1500;
////
////  Widget _quantity(){
////    return Row(
////      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////      children: <Widget>[
////        Padding(
////          padding: const EdgeInsets.all(8.0),
////          child: Text(
////              'Qty : ',
////            style: TextStyle(
////              fontSize: 25
////            ),
////          ),
////        ),
////        SizedBox(
////          height: 36,
////          width: 36,
////          child: FloatingActionButton(
////            heroTag: "btn1",
////            onPressed: add,
////            child: Icon(Icons.add),
////          ),
////        ),
////        Text(
////          '$_n',
////          style: TextStyle(
////            fontSize: 25
////          ),
////        ),
////        SizedBox(
////          height: 36,
////          width: 36,
////          child: FloatingActionButton(
////            heroTag: "btn2",
////            onPressed: minus,
////            child: Icon(
////              IconData(
////                  0xe15b, fontFamily: 'MaterialIcons'
////              ),
////                ),
////          ),
////        ),
////      ],
////    );
////  }
////
////  void add(){
////    setState(() {
////      _n++;
////      sum=sum+sum;
////    });
////  }
////  void minus() {
////    setState(() {
////      if (_n != 0)
////        _n--;
////    });
////  }
////
////  Widget _availableSize() {
////    return Center(
////      child: ToggleButtons(
////        borderRadius: BorderRadius.circular(10.0),
////          children: <Widget>[
////              Padding(
////                padding: const EdgeInsets.all(8.0),
////                child: Text(
////                  '$value1 g',
////                style:TextStyle(
////                  fontSize: 18.0
////                ),
////                ),
////              ),
////
////              Padding(
////                padding: const EdgeInsets.all(8.0),
////                child: Text(
////                    '$value2 g',
////                  style: TextStyle(
////                    fontSize: 18.0
////                  ),
////                ),
////              ),
////
////              Padding(
////                padding: const EdgeInsets.all(8.0),
////                child: Text(
////                    '$value3 g',
////                  style: TextStyle(
////                    fontSize: 18.0
////                  ),
////                ),
////              ),
////
////             Padding(
////               padding: const EdgeInsets.all(8.0),
////               child: Text(
////                   '$value4 g',
////                  style: TextStyle(
////                    fontSize: 18.0
////                  ),
////               ),
////             ),
////          ],
////          isSelected: isSelected,
////          onPressed: (int index) {
////            setState(() {
////              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
////                if (buttonIndex == index) {
////                  isSelected[buttonIndex] = true;
////                  var k=int.parse(widget.details.subPrice);
////                  assert(k is int);
////
////                  if(index==0){
////                    sum=(k)*value1*_n;
////                  }
////                  if(index==1){
////                    sum=(k)*value2*_n;
////                  }
////                  if(index==2){
////                    sum=(k)*value3*_n;
////                  }
////                  if(index==3){
////                    sum=(k)*value4*_n;
////                  }
////                } else {
////                  isSelected[buttonIndex] = false;
////                }
////              }
////            });
////          }
////      ),
////    );
////  }
////
////}
//
//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:timepass/Model.dart';
//import 'package:timepass/pages/ShoppingCart.dart';
//import 'package:timepass/sqlite/db_helper.dart';
//
//class DetailsPage extends StatefulWidget {
//  final SubCategory details;
//  DetailsPage({Key key, @required this.details}) : super(key: key);
//  @override
//  _DetailsPageState createState() => _DetailsPageState();
//}
//
//class _DetailsPageState extends State<DetailsPage> {
//  List<bool> isSelected = [
//    true,
//    false,
//    false,
//    false,
//  ];
//  List<bool> isSelected1 = [
//    true,
//    false,
//    false,
//    false,
//  ];
//  List<SubCategory> cart = [];
//
//  Future<List<SubCategory>> products;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  final heroTag = "assets/images/vegetables.jpeg";
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: ListView(children: <Widget>[
//        Container(
//          height: 300.0,
//          width: 400.0,
//          child: Carousel(
//            images: [
//              AssetImage(heroTag),
//              AssetImage("assets/images/shopping.jpeg"),
//              AssetImage(heroTag),
//            ],
//            showIndicator: true,
//            dotSize: 4.0,
//            dotSpacing: 15.0,
//            indicatorBgPadding: 5.0,
////              borderRadius: true,
//          ),
//        ),
//        Container(
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(45.0),
//                topRight: Radius.circular(45.0),
//              ),
//              color: Colors.white),
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
//                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(
//                      widget.details.subName,
//                      style: TextStyle(
//                        fontSize: 20,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
////                      Text(
////                        'Rs. '+(widget.details.subPrice.toString())+'/g',
////                        style: TextStyle(
////                          fontSize: 20,
////                          fontWeight: FontWeight.w800,
////                        ),
////                      ),
//                  ],
//                ),
//              ),
//              SizedBox(
//                height: 10,
//              ),
//              _availableSize(),
//              SizedBox(
//                height: 20,
//              ),
//              _availableSize1(),
//              SizedBox(
//                height: 20,
//              ),
//              _quantity(),
//              SizedBox(
//                height: 20,
//              ),
//
//              SizedBox(
//                height: 20,
//              ),
//              Card(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(10.0),
//                    side: BorderSide(color: Colors.black, width: .0)),
//                margin: EdgeInsets.only(left: 10, right: 10),
//                elevation: 0.0,
//                child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.all(10.0),
//                        child: Text(
//                          'Description : ',
//                          style: TextStyle(
//                            fontSize: 18,
//                          ),
//                        ),
//                      ),
//                      Divider(
//                        height: 10,
//                        color: Colors.black,
//                      ),
//                      Padding(
//                        padding:
//                            const EdgeInsets.only(left: 15, right: 18, top: 8),
//                        child: Text(
//                          'There are three reasons why I prefer jogging to other sports. '
//                          'One reason is that jogging is a cheap sport. I can practise it anywhere at'
//                          'any time with no need for a ball or any other equipment. '
//                          'Another reason why I prefer jogging is that it is friendly to my heart. '
//                          'I don’t have to exhaust myself or do excessive efforts while jogging.'
//                          'Finally, I prefer this sport because it is safe.'
//                          'It isn’t as risky as other sports like gymnastics, racing or horseback riding.'
//                          'For all these reasons, I consider jogging the best sport of all.',
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ],
//          ),
//        ),
//      ]),
//      bottomNavigationBar: Container(
//        height: 54,
//        child: RaisedButton(
//          onPressed: () {},
//          color: Colors.blue,
//          textColor: Colors.white,
//          child: Text('ADD TO CART'),
//        ),
//      ),
//    );
//  }
//
//  tocart() {
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => ShoppingCart(),
////      builder: (context)=>ShoppingCart(),
//      ),
//    );
//  }
//
//  var sum = 10000;
//  var _n = 1;
//  var indexValue = 0, priceValue = 20;
//  var value1 = 500, value2 = 750, value3 = 1000, value4 = 1500;
//  void add() {
//    setState(() {
//      _n++;
//      sum = sum + sum;
//    });
//  }
//
//  void minus() {
//    setState(() {
//      if (_n != 1) _n--;
//      if (indexValue == 0) {
//        sum = (value1 * priceValue * _n);
//      }
//      if (indexValue == 1) {
//        sum = (value2 * priceValue * _n);
//      }
//      if (indexValue == 2) {
//        sum = (value3 * priceValue * _n);
//      }
//      if (indexValue == 3) {
//        sum = (value4 * priceValue * _n);
//      }
//
//    });
//  }
//
//  Widget _quantity() {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      children: <Widget>[
//        Container(
//          width: 30,
//          height: 30,
//          child: OutlineButton(
//            padding: EdgeInsets.zero,
//            onPressed: add,
//            child: Icon(Icons.add),
//          ),
//        ),
//        Text(
//          '$_n',
//          style: TextStyle(fontSize: 18),
//        ),
//        Container(
//          width: 30,
//          height: 30,
//          child: OutlineButton(
//            padding: EdgeInsets.zero,
//            onPressed: minus,
//            child: FaIcon(
//              FontAwesomeIcons.minus,
//              size: 14,
//            ),
//          ),
//        ),
//        Padding(
//          padding: const EdgeInsets.all(10.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              Text(
//                'MRP: ',
//                style: TextStyle(
//                  fontSize: 18,
//                  fontWeight: FontWeight.w500,
//                ),
//              ),
//              Text(
//                'Rs.$sum',
//                style:
//                TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//              ),
//            ],
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget _availableSize() {
//
//    return Center(
//      child: ToggleButtons(
//          borderRadius: BorderRadius.circular(10.0),
//          children: <Widget>[
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
//
//
//  Widget _availableSize1() {
//
//    return Center(
//      child: ToggleButtons(
//          borderRadius: BorderRadius.circular(10.0),
//          children: <Widget>[
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
//          isSelected: isSelected,
//          onPressed: (int index) {
//            var k = (widget.details.subPrice);
//            assert(k is int);
//            setState(() {
//              for (int buttonIndex = 0;
//              buttonIndex < isSelected.length;
//              buttonIndex++) {
//                if (buttonIndex == index) {
//                  isSelected[buttonIndex] = true;
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
//                  isSelected[buttonIndex] = false;
//                }
//              }
//            });
//          }),
//    );
//  }
//
//
//
//}
//
////
////
////Row(
////mainAxisAlignment: MainAxisAlignment.start,
////children: <Widget>[
////Padding(
////padding: EdgeInsets.all(8.0),
////child:ButtonTheme(
////height: 45,
////child: RaisedButton.icon(
////onPressed: () async{
////cart.add(widget.details);
////int i= await DatabaseHelper.instance.insert({
////DatabaseHelper.columnName : widget.details.subName,
////DatabaseHelper.columnSubId : widget.details.subId,
////DatabaseHelper.columnPrice : widget.details.subPrice,
////DatabaseHelper.columnQuantity : widget.details.subQuantity,
////DatabaseHelper.columnImageUrl : widget.details.subImageUrl,
////});
////print('inserted id is $i');
////},
////shape: RoundedRectangleBorder(
////borderRadius: BorderRadius.circular(8.0)
////),
////color: Colors.green,
////textColor: Colors.white,
////icon: Icon(Icons.shopping_cart),
////label: Text(
////'ADD TO CART',
////style: TextStyle(
////fontSize: 16
////),
////),
////),
////) ,
////),
////],
////)
//
////
////return ToggleButtons(
////borderRadius: BorderRadius.circular(10.0),
////children: <Widget>[
////Padding(
////padding: const EdgeInsets.all(8.0),
////child: Text(
////'$value1 g',
////style: TextStyle(fontSize: 16.0),
////),
////),
////Padding(
////padding: const EdgeInsets.all(8.0),
////child: Text(
////'$value2 g',
////style: TextStyle(fontSize: 16.0),
////),
////),
////Padding(
////padding: const EdgeInsets.all(8.0),
////child: Text(
////'$value3 g',
////style: TextStyle(fontSize: 16.0),
////),
////),
////Padding(
////padding: const EdgeInsets.all(8.0),
////child: Text(
////'$value4 g',
////style: TextStyle(fontSize: 16.0),
////),
////),
////],
////isSelected: isSelected,
////onPressed: (int index) {
////var k = (widget.details.subPrice);
////assert(k is int);
////setState(() {
////for (int buttonIndex = 0;
////buttonIndex < isSelected.length;
////buttonIndex++) {
////if (buttonIndex == index) {
////isSelected[buttonIndex] = true;
////indexValue = index;
////priceValue = k;
////if (index == 0) {
////sum = (k) * value1 * _n;
////}
////if (index == 1) {
////sum = (k) * value2 * _n;
////}
////if (index == 2) {
////sum = (k) * value3 * _n;
////}
////if (index == 3) {
////sum = (k) * value4 * _n;
////}
////if (index == 4) {
////sum = (k) * value4 * _n;
////}
////} else {
////isSelected[buttonIndex] = false;
////}
////}
////});
////});
