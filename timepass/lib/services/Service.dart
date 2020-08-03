import 'dart:convert';
import 'package:http/http.dart'as http;

class urls{
  static const String base_url = "http://spices.acknowtech.in/public/api/v1";
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
//    print('lat in service is'+lat.toString());
//    print('long in service is'+long.toString());
//    print('mobile in service is'+mobile.toString());
//    print('address1 in service is'+address1.toString());
//    print('address2 in service is'+address2.toString());
//    print('pincode in service is'+pincode.toString());

    var body=jsonEncode({
      'mobile_no': mobile,
      'address_line_1':address1,
      "address_line_2":address2,
      "pincode":pincode,
      "latitude":lat,
      "longitude":long
    });
    final http.Response response = await http.post(
      urls.base_url+'/customer/createAddress',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:body,
    );
    if (response.statusCode == 200) {
//      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load response of google map');
    }
  }


  static Future getRates(List products,int address_id,int mobile_no,[String promocode]) async{
    if(promocode==null){
      promocode="";
    }
    var body=jsonEncode({
      'products':products,
      'address_id':address_id,
      'mobile_no':mobile_no,
      'promocode':promocode,
    });
    final http.Response response = await http.post(
      urls.base_url+'/customer/getRate',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load response of rates');
    }
  }

  static Future placeOrder(List products,int address_id,int mobile_no,[String promocode]) async{
    if(promocode==null){
      promocode="";
    }
    var body=jsonEncode({
      'products':products,
      'address_id':address_id,
      'mobile_no':mobile_no,
      'promocode':promocode,
    });
    final http.Response response = await http.post(
      urls.base_url+'/customer/placeOrder',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load response of place orders');
    }
  }

  static Future getOrders(int mobile) async{
    print('mobile no. in service is'+mobile.toString());
    final http.Response response = await http.get(
      urls.base_url+'/customer/getAllOrders?mobile_no='+mobile.toString(),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get address from server');
    }
  }


  static Future checkPaymentStatus(int order_id,String razorpay_id) async{
    var body=jsonEncode({
      'order_id': order_id,
      'razorpay_order_id': razorpay_id,
    });
//    print(body);
    final http.Response response = await http.post(
      urls.base_url+'/customer/checkPaymentStatus',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:body,
    );
    if (response.statusCode == 200) {
//      final Welcome standards = welcomeFromJson(response.body);
      print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load response of standards');
    }
  }


}