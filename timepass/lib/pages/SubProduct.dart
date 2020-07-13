

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timepass/Model.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:timepass/pages/DetailsPage.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/theme.dart';

class SubProduct extends StatefulWidget {
  Welcome id1;
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
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Padding(
              padding: const EdgeInsets.only(top: 50.0,left: 15.0,bottom: 2.0),
              child: Row(
                children: <Widget>[
                  IconButton(
//                    icon: Icon(Icons.menu,size: 30,),
                    icon: FaIcon(FontAwesomeIcons.alignLeft),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                  Text(
                    widget.id1.name,
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w800,
                      color: MyColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 7.0,right:10.0,bottom: 10),
            child: Container(
              height: 40,
              margin: EdgeInsets.only(top: 5,left:5),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
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
            child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child:new ListView.builder(
              itemCount:widget.id1.subCategory.length,
//              padding: const EdgeInsets.only(top:15.0,left: 15.0,right: 15.0),
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
                      margin: EdgeInsets.only(left: 10,
                          right: 10,bottom: 5),
//                      width: 330,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        elevation:2,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 130.0,
                              height: 128.0,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                    image: NetworkImage(widget.id1.imageUrl),
                                      fit: BoxFit.cover),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
//                                  boxShadow: [
//                                    BoxShadow(blurRadius: 2.0)
//                                  ]
                              ),
                            ),
                            Container(
                              width: 200,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(
                                           widget.id1.subCategory[i].subName+'nf;nsnf;slnfslkdjfjs;dfns;n',
                                           style: TextStyle(
                                             fontSize: 15.0,
                                             fontWeight: FontWeight.w500,
                                             letterSpacing: 0.8,
                                           ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                         ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3.0),
                                      child: Text(
                                        'Rs.'+(widget.id1.subCategory[i].subPrice).toString()+'/g',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(top: 0),
//                                        child: Row(
//                                          children: <Widget>[
//                                            Padding(
//                                              padding: const EdgeInsets.only(right: 23.0),
//                                              child: ButtonTheme(
//                                                minWidth:20.0,
//                                                child: RaisedButton.icon(
//                                                  onPressed: (){},
//                                                  color: Colors.green,
//                                                  label: Text(
//                                                    'Buy Now',
//                                                    style: TextStyle(
//                                                      fontSize: 15
//                                                    ),
//                                                  ),
//                                                  shape: RoundedRectangleBorder(
//                                                    borderRadius: BorderRadius.circular(20)
//                                                  ),
//                                                  textColor: Colors.white,
//                                                  icon: Icon(Icons.shopping_cart,size: 15,),
//                                                ),
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      )
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
          ),
        ],
      ),
    );
  }
}


