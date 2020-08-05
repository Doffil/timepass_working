import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:timepass/pages/MyDrawer.dart';
import 'package:timepass/pages/Product.dart';
import 'package:timepass/pages/ShoppingIcon.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/themes/light_color.dart';
import 'package:timepass/themes/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';



class SubCategories extends StatefulWidget {
  final subCategories;
  final categoryName;


  const SubCategories({Key key,this.subCategories,this.categoryName}) : super(key: key);
  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {

  bool _loading;
  var _controller = TextEditingController();
  bool showCross=false;
  List duplicateSubcategoriesList=new List();
  List originalSubcategoriesList=new List();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final spinKit = SpinKitWave(
    color: Colors.lightBlue,
    size: 30,
  );

  @override
  void initState() {
    showCross=false;
    super.initState();
    originalSubcategoriesList=widget.subCategories;
    duplicateSubcategoriesList=widget.subCategories;
    _loading = false;
  }
  int cartLength = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      showCross=false;
    });
    },
      child: Scaffold(
          key: scaffoldKey,
          drawer: MyDrawer(),
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
                            _loading ? 'Loading...' : widget.categoryName,
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
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Products",
                                hintStyle: TextStyle(fontSize: 12),
                                contentPadding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 0, top: 5),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.black54),
                              suffixIcon:showCross?
                              IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: (){
                                  setState(() {
                                    duplicateSubcategoriesList=originalSubcategoriesList;
                                    showCross=false;
                                    _controller.clear();
                                  });
                                },
                              ): Icon(Icons.arrow_drop_down,size: 2,)
                            ),

                            onChanged: (string) {
                              setState(() {
                                showCross=true;
                                duplicateSubcategoriesList =originalSubcategoriesList
                                    .where((u) => (u["product_subcategory_name"]
                                        .toLowerCase()
                                        .contains(string.toLowerCase())))
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
                _loading
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: spinKit,
                          )
                        ],
                      )
                    :duplicateSubcategoriesList.length == 0
                    ? Center(
                  child: Text(
                    'No sub-categories found !!!',
                    style: TextStyle(fontSize: 18),
                  ),
                )
                    :
                Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: new GridView.builder(
                              itemCount:duplicateSubcategoriesList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Colors.white,
                                  margin: EdgeInsets.fromLTRB(7, 7, 10, 10),
                                  elevation: 3.0,
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        splashColor: Colors.orange,
                                        onTap: () {
                                          print(duplicateSubcategoriesList[index]["id"]);
                                          if(duplicateSubcategoriesList[index]["is_active"] ==1){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Product(productId: duplicateSubcategoriesList[index]["id"],
                                                    subCategoryName: duplicateSubcategoriesList[index]["product_subcategory_name"]),
                                              ),
                                            );
                                          }else{
                                            Flushbar(
                                              margin: EdgeInsets.all(8),
                                              borderRadius: 8,
                                              backgroundColor:
                                              Colors.red,
                                              flushbarPosition:
                                              FlushbarPosition.TOP,
                                              message:
                                              "There are no products for this sub-category,Sorry!!!",
                                              duration:
                                              Duration(seconds: 4),
                                            )..show(context);
                                          }

                                        },
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Flexible(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10.0),
                                                    topRight: Radius.circular(10.0)),
                                                child: CachedNetworkImage(
                                                  imageUrl: duplicateSubcategoriesList[index]["product_subcategory_image_url"],
                                                  placeholder: (context, url) {
                                                    return Icon(Icons.shopping_cart);
                                                  },
                                                  fit: BoxFit.fill,
                                                  height: 130,
                                                  width: 220,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 9.0),
                                              child: Opacity(
                                                opacity: 0.8,
                                                child: Text(
                                                  duplicateSubcategoriesList[index]["product_subcategory_name"],
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 0.5),
                                                ),
                                              ),
                                            ),
//                                            Padding(
//                                              padding: const EdgeInsets.only(left: 9.0, bottom: 6.0),
//                                              child: Text("",
//                                                style: TextStyle(
//                                                  fontSize: 12.0,
//                                                ),
//                                              ),
//                                            )
                                          ],
                                        ),
                                      )),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}