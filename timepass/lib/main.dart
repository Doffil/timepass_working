import 'package:flutter/material.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/SplashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      routes: <String,WidgetBuilder>{
          '/HomeScreen':(BuildContext context)=> new HomeScreen()
        }
    );
  }
}