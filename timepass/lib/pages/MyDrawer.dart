import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timepass/pages/shopping-copy.dart';
import 'package:timepass/sqlite/db_helper.dart';
import '../main.dart';
import 'Categories.dart';
import 'OrderDetails.dart';
import 'ProfilePage.dart';
import 'SupportPage.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Categories()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.shoppingBag),
            title: Text('Shopping-Cart'),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      duration: Duration(milliseconds: 500),
                      child: ShoppingCartCopy()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.stickyNote),
            title: Text('Orders'),
            onTap: () {
              //yet to implement
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderDetails()));
            },
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Support'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SupportPage()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.language),
            title: Text('Language'),
            onTap: () {
              //yet to implement
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.userCircle),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.signOutAlt),
            title: Text('Sign-Out'),
            onTap: () async {
              //add at the last
              await DatabaseHelper.instance.deleteAll();
              SharedPreferences prefs =
              await SharedPreferences.getInstance();
              FirebaseAuth.instance.signOut();
              prefs.setString('customerName', null);
              prefs.setString('customerEmailId', null);
              prefs.setString('customerId', null);
              prefs.setBool("isLoggedIn", false);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
    );
  }
}
