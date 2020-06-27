import 'package:flutter/material.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/pages/ProfilePage.dart';
import 'package:timepass/pages/ShoppingCart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
    );
  }
}