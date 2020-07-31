import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:path/path.dart';
import 'package:timepass/Model.dart';
import 'package:async/async.dart';

class urls{
  static const String base_url = "http://192.168.43.96:8000/api/v1";
  static int save_mobile_no;
}

class Service{

  static Future checkUser(int mobile) async{
    final http.Response response = await http.get(
      urls.base_url+'/customer/isNewUser?mobile_no='+mobile.toString(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check user');
    }
  }

  static Future registerUser(String name,int mobile,String email) async{
    print(mobile);
    var body=jsonEncode({
      'name': name,
      'mobile_no': mobile,
      'email':email
    });
//    print(body);
    final http.Response response = await http.post(
      urls.base_url+'/customer/createNewUser',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:body,
    );
    if (response.statusCode == 200) {
//      final Welcome standards = welcomeFromJson(response.body);
    print(response.body);
    urls.save_mobile_no=mobile;
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load response of standards');
    }
  }

  static Future getCategories() async{
    final http.Response response = await http.get(
      urls.base_url+'/productCategory',
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check user');
    }
  }

  static Future getProducts(int id) async{
    final http.Response response = await http.get(
      urls.base_url+'/products?subcategory_id='+id.toString(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check user');
    }
  }

  static Future getAddress(int mobile) async{
    final http.Response response = await http.get(
      urls.base_url+'/customer/getAddress?mobile_no='+mobile.toString(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get address from server');
    }
  }

  static Future registerAddress(int mobile,String address1,String address2,String pincode,double lat,double long) async{
    var body=jsonEncode({
      'mobile_no': mobile,
      'address_line_1':address1,
      "address_line_2":address2,
      "pincode":pincode,
      "latitude":lat,
      "longitude":long
    });
//    print(body);
    final http.Response response = await http.post(
      urls.base_url+'/customer/createAddress',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:body,
    );
    if (response.statusCode == 200) {
//      final Welcome standards = welcomeFromJson(response.body);
      print(response.body);
      urls.save_mobile_no=mobile;
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load response of standards');
    }
  }

}