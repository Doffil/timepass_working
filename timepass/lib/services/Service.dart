import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:timepass/Model.dart';
import 'package:async/async.dart';
class Service{
  static String url ='http://192.168.43.41:8000/api/v1/productCategory';
  static Future<Welcome> getProducts() async{
    try{
      final response= await http.get(url);
      if(response.statusCode ==200 ){
        final Welcome products= welcomeFromJson(response.body);
        return products;
      }else{
        return Welcome();
      }
    }catch(e){
      return Welcome();
    }
  }

}