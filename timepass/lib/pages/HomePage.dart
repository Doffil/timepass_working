import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:timepass/pages/SubProduct.dart';

class SubCategory{
  String description;
  String subcategory_id;
  SubCategory({this.subcategory_id,this.description});
}

class Model {
  String id;
  String name;
  String title;
  String imageUrl;
  bool subcategory;
//  Map<SubCategory,String>subcategories;
  List<SubCategory> subcategories;
  Model({this.id, this.name, this.title,this.imageUrl,this.subcategory,this.subcategories});
}



class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = Text(
    "Search Demo",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.orange,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<Model> _list;
  List<Model> _searchList = List();

  bool _IsSearching;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    init();
  }

  void init() {
    _list=
        _list = List();
    _list.add(
      Model(id: "1", name: "Vegetables", title: "a title 1",
          imageUrl: "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg",
          subcategory: true,
      ),
    );
    _list.add(
      Model(id: "2", name: "Fruits", title: "a title 2",
          imageUrl: "https://cdn-prod.medicalnewstoday.com/content/images/hero/325/325253/325253_1100.jpg"),
    );
    _list.add(
      Model(id: "3", name: "Breads", title: "b title 3",
          imageUrl: "https://www.biggerbolderbaking.com/wp-content/uploads/2020/04/Hearty-Yeast-Free-Bread-WS-Thumbnail.jpg"),
    );
    _list.add(
      Model(id: "4", name: "Sweets", title: "b title 4",
          imageUrl: "https://c.ndtvimg.com/2019-10/o52ta3a8_sweets-_625x300_26_October_19.jpg"),
    );
    _list.add(
      Model(id: "5", name: "Spices", title: "b title 5",
          imageUrl: "https://marketresearchbiz-ikwnsbmbizhvmufcjx.netdna-ssl.com/wp-content/uploads/2017/11/spices-market-400x225.jpg"),
    );
    _list.add(
      Model(id: "6", name: "Dal Types", title: "b title 6",
          imageUrl: "https://i.ndtvimg.com/i/2016-11/types-of-dal_620x350_41479190401.jpg"),
    );
    _list.add(
      Model(id: "7", name: "Milk Products", title: "b title 7",
          imageUrl: "https://cdn.dnaindia.com/sites/default/files/styles/full/public/2018/09/21/734051-milk-products.jpg"),
    );
    _searchList = _list;

    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
          _buildSearchList();
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          _buildSearchList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: buildBar(context),
        body: GridView.builder(
            itemCount: _searchList.length,
            itemBuilder: (context, index) {
              return GridItem(_searchList[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            )));
  }

  List<Model> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList = _list;
    } else {
      _searchList = _list
          .where((element) =>
      element.name.toLowerCase().contains(_searchText.toLowerCase()) ||
          element.title.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList;
    }
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        iconTheme: IconThemeData(color: Colors.orange),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.orange,
                  );
                  this.appBarTitle = TextField(
                    controller: _searchQuery,
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                    decoration: InputDecoration(
                        hintText: "Search here..",
                        hintStyle: TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.orange,
      );
      this.appBarTitle = Text(
        "Search Demo",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class GridItem extends StatelessWidget {
  final Model model;
  GridItem(this.model);

  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      elevation: 10.0,
      child:Container(
        alignment: Alignment.center,
        child:InkWell(
          splashColor: Colors.orange,
          onTap: (){
            print(this.model.subcategory);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=> SubProduct(id1: model),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/shopping.jpeg',
                    image: this.model.imageUrl,
                    fit: BoxFit.fitHeight,
                    width: 240,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  this.model.name,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight:FontWeight.w500
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








