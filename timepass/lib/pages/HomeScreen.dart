import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timepass/Model.dart';
import 'package:timepass/pages/Categories.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/pages/Product.dart';
import 'package:timepass/pages/home_page.dart';
import 'package:timepass/stores/login_store.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedItem = 0;
  List<Widget> _pages = [Categories(), ShoppingCart(), ProfilePage()];
  var pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
//    return Consumer<LoginStore>(
//        builder: (_, loginStore, __) {
          return Scaffold(
              body: PageView(
                children: _pages,
                onPageChanged: (index) {
                  setState(() {
                    _selectedItem = index;
                  });
                },
                controller: pagecontroller,
              ),
//              bottomNavigationBar: FancyBottomNavigation(
//                tabs: [
//                  TabData(iconData: Icons.home, title: "Home"),
//                  TabData(iconData: Icons.shopping_cart, title: "Shopping-Cart"),
//                  TabData(iconData: Icons.supervised_user_circle, title: "Profile")
//                ],
//                activeIconColor: Colors.blue,
//                inactiveIconColor: Colors.blue,
//                onTabChangedListener: (index) {
//                  setState(() {
//                    _selectedItem = index;
//                    pagecontroller.animateToPage(
//                    _selectedItem,
//                      duration: Duration(milliseconds: 200),
//                      curve: Curves.linear);
//                    });
//                },
//              )
          );
        }
  }







//
//bottomNavigationBar: BottomNavigationBar(
//items: [
//BottomNavigationBarItem(
//title:Text('Home'),
//icon: Icon(Icons.home)
//),
//BottomNavigationBarItem(
//title:Text('Shopping-Cart'),
//icon: Icon(Icons.shopping_cart)
//),
//BottomNavigationBarItem(
//title:Text('Profile'),
//icon: Icon(Icons.supervised_user_circle),
//),
//],
//currentIndex: _selectedItem,
//selectedItemColor: MyColors.primaryColor,
//onTap: (index) {
//setState(() {
//_selectedItem = index;
//pagecontroller.animateToPage(_selectedItem,
//duration: Duration(milliseconds: 200),
//curve: Curves.linear);
//});
//},
//)