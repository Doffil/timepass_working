import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grocery/pages/home_page.dart';
import 'package:grocery/pages/login_page.dart';
import 'package:grocery/stores/login_store.dart';
import 'package:grocery/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<LoginStore>(context, listen: false).isAlreadyAuthenticated().then((result) {
      if (result) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const HomePage()), (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginPage()), (Route<dynamic> route) => false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: MyColors.primaryColor,
    body:Center(
      child: Image.asset("assets/img/shopping.jpeg"),
    )
    );
  }
}
