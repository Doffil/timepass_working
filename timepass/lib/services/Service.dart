import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:timepass/Model.dart';
import 'package:async/async.dart';
class Service{
  static String url ='https://grocery999.000webhostapp.com/data.json';
  static Future<List<Welcome>> getProducts() async{
    try{
      final response= await http.get(url);
      if(response.statusCode ==200 ){
        final List<Welcome> products= welcomeFromJson(response.body);
        return products;
      }else{
        return List<Welcome>();
      }
    }catch(e){
      return List<Welcome>();
    }
  }

}