import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DemoLocalizations{
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String,String> _localizedValues;

  Future load() async{
//    String jsonStringValues=
//    await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

  final response=await http.get('https://grocery999.000webhostapp.com/${locale.languageCode}.json');
//  var response;
//    if(locale.languageCode=="en"){
//     response = await http.get('https://grocery999.000webhostapp.com/en.json');
//    }else if( locale.languageCode=="hi"){
//     response = await http.get('https://grocery999.000webhostapp.com/hi.json');
//    }else{
//     response = await http.get('https://grocery999.000webhostapp.com/mr.json');
//    }
    Map<String,dynamic> mappedJson1= json.decode(utf8.decode(response.bodyBytes));
    _localizedValues= mappedJson1.map((key, value) => MapEntry(key,value.toString()));

  }
  String getTranslatedValues(String key){
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<DemoLocalizations> delegate = DemoLocalizationsDelegate();
}


class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale){

    return ['en','hi','mr'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) async{
    DemoLocalizations localizations = new DemoLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
