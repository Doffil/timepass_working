import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localizationworking/classes/languages.dart';
import 'package:localizationworking/localization/localization_constant.dart';
import 'package:localizationworking/main.dart';



class InputPage extends StatefulWidget{

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage>{

  void _changeLanguage(Languages languages){
    Locale temp;
    switch(languages.langugeCode){
      case 'en':
        temp=Locale(languages.langugeCode);
        break;
      case 'hi':
        temp=Locale(languages.langugeCode);
        break;
      case 'mr':
        temp=Locale(languages.langugeCode);
        break;
      default: temp=Locale(languages.langugeCode);
    }

    MyApp.setLocale(context,temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: DropdownButton(
              onChanged: (Languages language){
                _changeLanguage(language);
              },
              icon: Icon(
                Icons.language,
                color: Colors.white
              ),
              items: Languages.languagesList()
              .map<DropdownMenuItem<Languages>>((lang) => DropdownMenuItem(
                value: lang,
                child: Row(
                  children: <Widget>[
                    Text(lang.name),
                ],
              ),
              )
              ).toList()
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[
            Text(getTranslated(context, 'Potato'),
              style: TextStyle(
                fontSize: 30.0
              ),)
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Shopping-Cart'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),

          ),
        ],

        selectedItemColor: Colors.purple[400],
      ),
    );
  }
}