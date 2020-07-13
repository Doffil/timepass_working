import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timepass/Model.dart';
import 'package:timepass/pages/HomePage.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/pages/SubProduct.dart';
import 'package:timepass/pages/home_page.dart';
import 'package:timepass/stores/login_store.dart';

class ShoppingCartScreen extends StatefulWidget {
  final Welcome id2;
  ShoppingCartScreen({Key key, @required this.id2}) :super(key: key);
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {

  int _selectedItem = 1;
  var pagecontroller = PageController();



  @override
  Widget build(BuildContext context) {
//    return Consumer<LoginStore>(
//        builder: (_, loginStore, __) {

    Widget child;
    switch (_selectedItem) {
      case 0:
        child = SearchList();
        break;
      case 1:
        child = ShoppingCart();
        break;
      case 2:
        child = ProfilePage();
        break;
    }
    return Scaffold(
        body:SizedBox.expand(child: child),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  title:Text('Home'),
                  icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                  title:Text('Shopping-Cart'),
                  icon: Icon(Icons.shopping_cart)
              ),
              BottomNavigationBarItem(
                title:Text('Profile'),
                icon: Icon(Icons.supervised_user_circle),
              ),
            ],
            currentIndex: _selectedItem,
            onTap: (index) {
              setState(() {
                _selectedItem = index;
//              pagecontroller.animateToPage(_selectedItem,
//                  duration: Duration(milliseconds: 200),
//                  curve: Curves.linear);
//            });
              },
              );
            }
        ));
  }
}