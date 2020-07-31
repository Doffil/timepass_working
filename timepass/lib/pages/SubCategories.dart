import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/main.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/Product.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/themes/light_color.dart';
import 'package:timepass/themes/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';



class SubCategories extends StatefulWidget {
  final subCategories;
  final category_name;


  const SubCategories({Key key,this.subCategories,this.category_name}) : super(key: key);
  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {

  bool _loading;
  var _controller = TextEditingController();

  List duplicate_subcategories_list=new List();
  List original_subcategories_list=new List();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final spinkit = SpinKitWave(
    color: Colors.lightBlue,
    size: 30,
  );

  @override
  void initState() {
    super.initState();
    original_subcategories_list=widget.subCategories;
    duplicate_subcategories_list=widget.subCategories;
    _loading = false;
  }


  int cartLength = 0;
  _getMoreData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cartLength = prefs.getInt('cartLength') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
    FocusScope.of(context).requestFocus(new FocusNode());
    },
      child: Scaffold(
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
                          fontWeight: FontWeight.bold),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Categories()));
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.shoppingBag),
                  title: Text('Shopping-Cart'),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType
                                .rightToLeft,
                            duration:
                            Duration(milliseconds: 500),
                            child: ShoppingCartCopy()));
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.userCircle),
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  onTap: () {
                    //yet to implement
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.signOutAlt),
                  title: Text('Sign-Out'),
                  onTap: ()async {
                    //add at the last
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    FirebaseAuth.instance.signOut();
                    prefs.setString('customerName', null);
                    prefs.setString('customerEmailId', null);
                    prefs.setString('customerId', null);
                    prefs.setBool("isLoggedIn", false);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                  },
                ),
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 2.0),
                  child: Row(
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
                              _loading ? 'Loading...' : widget.category_name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.orangeAccent),
                          child: Stack(
                            children: <Widget>[
                              IconButton(
                                  icon: FaIcon(FontAwesomeIcons.shoppingBag,
                                      size: 20),
                                  color: Colors.black,
                                  onPressed: () => {
                                  Navigator.push(
                                  context,
                                  PageTransition(
                                  type: PageTransitionType
                                      .rightToLeft,
                                  duration:
                                  Duration(milliseconds: 500),
                                  child: ShoppingCartCopy()))
                                      }),
                              new Positioned(
                                right: 2,
                                bottom: 4,
                                child: new Stack(
                                  children: <Widget>[
                                    new Icon(Icons.brightness_1,
                                        size: 20.0, color: Colors.green[800]),
                                    new Positioned(
                                        top: 3.0,
                                        right: 3.0,
                                        child: new Center(
                                          child: new Text(
                                            cartLength.toString(),
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ])),
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
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: (){
                                setState(() {
                                  duplicate_subcategories_list=original_subcategories_list;
                                  _controller.clear();
                                });
                              },
                            )
                          ),

                          onChanged: (string) {
                            setState(() {
                              duplicate_subcategories_list =original_subcategories_list
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
                          child: spinkit,
                        )
                      ],
                    )
                  : Expanded(
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: new GridView.builder(
                            itemCount:duplicate_subcategories_list.length,
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
                                        print(duplicate_subcategories_list[index]["id"]);
                                        if(duplicate_subcategories_list[index]["is_active"] ==1){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Product(productId: duplicate_subcategories_list[index]["id"],
                                                  subCategoryName: duplicate_subcategories_list[index]["product_subcategory_name"]),
                                            ),
                                          );
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
                                                imageUrl: duplicate_subcategories_list[index]["product_subcategory_image_url"],
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
                                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 9.0),
                                            child: Opacity(
                                              opacity: 0.8,
                                              child: Text(
                                                duplicate_subcategories_list[index]["product_subcategory_name"],
                                                softWrap: true,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.5),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 9.0, bottom: 6.0),
                                            child: Text(
                                              '(40)',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          )
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
          )),
    );
  }
}