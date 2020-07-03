import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timepass/pages/HomePage.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/ShoppingCart.dart';
import 'package:timepass/stores/login_store.dart';
import 'package:timepass/theme.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedItem = 0;
  List<Widget> _pages = [SearchList(), ShoppingCart(), ProfilePage()];
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
              bottomNavigationBar: FloatingNavbar(
                items: [
                  FloatingNavbarItem(
                    icon: Icons.home,
                    title: 'Home',
                  ),
                  FloatingNavbarItem(
                    icon: Icons.shopping_cart,
                    title: 'Shopping-Cart',
                  ),
                  FloatingNavbarItem(
                    icon: Icons.account_circle,
                    title: 'Profile',
                  ),
                ],
                currentIndex: _selectedItem,
                selectedItemColor: MyColors.primaryColor,
                onTap: (index) {
                  setState(() {
                    _selectedItem = index;
                    pagecontroller.animateToPage(_selectedItem,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.linear);
                  });
                },
              )
          );
        }
  }