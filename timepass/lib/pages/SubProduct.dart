
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timepass/Model.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:timepass/pages/DetailsPage.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/theme.dart';

class SubProduct extends StatefulWidget {
  final Welcome id1;
  var len;
  final ValueSetter<SubCategory> valueSetter;
  SubProduct({Key key, @required this.id1,this.valueSetter}) :super(key: key);
  @override
  _SubProductState createState() => _SubProductState();
}

class _SubProductState extends State<SubProduct> {

  int _selectedItem = 0;
   List<SubCategory>_subproducts;
   List<SubCategory>cart=[];
  List<SubCategory>_subfilteredProducts;

  void tapcart(){
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
    super.initState();
      setState(() {
        _subproducts=widget.id1.subCategory;
        _subfilteredProducts=_subproducts;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Padding(
              padding: const EdgeInsets.only(top: 24.0,left: 5.0,bottom: 2.0),
              child: Text(
                widget.id1.name,
                style: TextStyle(
                  fontSize: 30,
                  color: MyColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 10.0,right:10.0),
            child: Container(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: Icon(
                      Icons.search
                  ),
                  hintText: 'Search the sub-product',
                ),
                onChanged: (string){
                  setState(() {
                    _subfilteredProducts=_subproducts.where((u) =>
                    (u.subName.toLowerCase().contains(string.toLowerCase()))).toList();
                  });
                  if(string.length==null){
                    FocusScope.of(context).requestFocus(new FocusNode());
                  }
                },
              ),
            ),
          ),

          Expanded(
            child: new ListView.builder(
              itemCount:widget.id1.subCategory.length,
              padding: const EdgeInsets.only(top:15.0,left: 15.0,right: 15.0),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=> DetailsPage(details:widget.id1.subCategory[i]),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 372,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 9,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15.0),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: NetworkImage(widget.id1.imageUrl),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                      boxShadow: [
                                        BoxShadow(blurRadius: 2.0)
                                      ]),
                                ),
                            ),
                            Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0,top: 9.0),
                                        child: Text(
                                          widget.id1.subCategory[i].subName,
                                          style: TextStyle(
                                              fontSize: 18.0
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7.0,left: 10.0),
//                                      child: Text(
//                                        (widget.id1.subCategory[i].subPrice).toString(),
//                                        style: TextStyle(
//                                          fontSize: 14.0,
//                                          fontWeight: FontWeight.w400
//                                        ),
//                                      ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0,left: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 23.0),
                                              child: ButtonTheme(
                                                minWidth:20.0,
                                                child: OutlineButton(
                                                  child: Icon(Icons.favorite_border),
                                                  shape:RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ButtonTheme(
                                              minWidth: 20.0,
                                              child: OutlineButton(
                                                child: Icon(Icons.shopping_cart),
                                                shape:RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(6.0)
                                                ),
                                                onPressed:(){
                                                    cart.add(widget.id1.subCategory[i]);
//                                           widget.valueSetter(widget.id1.subCategory[i]);
                                              },
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                              ),

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


