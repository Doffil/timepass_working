import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timepass/pages/HomeScreen.dart';
import 'package:timepass/SplashScreen.dart';
import 'package:timepass/pages/splash_page.dart';
import 'package:timepass/stores/login_store.dart';
import 'package:timepass/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeScreen(),
    );
//        return MultiProvider(
//    providers: [
//    Provider<LoginStore>(
//        create: (_) => LoginStore(),
//    )
//    ],
//    child: const MaterialApp(
//    home: SplashPage(),
//    ),
//    );
  }
}