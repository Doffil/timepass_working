import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:timepass/Model.dart';
import 'package:timepass/pages/SubProduct.dart';
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
          margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
          elevation: 10.0,
          child:Container(
              alignment: Alignment.center,
              child:InkWell(
                splashColor: Colors.orange,
                onTap: (){
                  print(this.model.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=> SubProduct(id1: model),
              ),
            );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
              Flexible(
                child: ClipRRect(
//                  borderRadius: BorderRadius.circular(10.0),
                borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0),topRight: Radius.circular(10.0)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/shopping.jpeg',
                    image: this.model.imageUrl,
                    fit: BoxFit.fill,
                    height: 142 ,
                    width: 240,
                  ),
                ),
              ),
                    Padding(
                      padding: EdgeInsets.only(top:5.0,bottom: 5.0,left: 9.0),
                      child: Text(
                        this.model.name,
                        softWrap: true,
//                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight:FontWeight.w500
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0,bottom: 6.0),
                      child: Text(
                        '(40)',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    )
                  ],
                ),
              )
          ),
        );

      }
}

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<Welcome>_products;
  List<Welcome>_filteredProducts;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading=true;
    Service.getProducts().then((products){
      setState(() {
        _products=products;
        _filteredProducts=_products;
        _loading=false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
        padding: const EdgeInsets.only(top: 24.0,left: 5.0,bottom: 2.0),
        child: Text(
        'Products',
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
                  hintText: 'Search the product',
                ),
                onChanged: (string){
                  setState(() {
                    _filteredProducts=_products.where((u) =>
                    (u.name.toLowerCase().contains(string.toLowerCase()))).toList();
                  });
                  if(string.length==null){
                    FocusScope.of(context).requestFocus(new FocusNode());
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                itemCount: null==_filteredProducts? 0 :_filteredProducts.length,
                itemBuilder:(context,index){
//                Welcome product= _filteredProducts[index];
                  return GridItem(_filteredProducts[index]);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ),
          )
        ],
    ));
  }

}