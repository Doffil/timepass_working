import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timepass/Model.dart';

class DatabaseHelper{
  static final _dbName = 'myDatabase.db';
  static final _dbversion = 1;
  static final _tableName = 'Products';
  static final Id = '_id';
  static final productId = 'productId';
  static final name = 'productName';
  static final sPrice = 'productSPrice';
  static final quantity = 'productQuantity';
  static final imageUrl = 'productImageUrl';
  static final varId = 'productVariableId';
  static final aPrice = 'productAPrice';
  static final vName = 'productVName';
  static final availableQuantity = 'productAvailableQuantity';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance= DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async{
    if(_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,_dbName);
    return await openDatabase(path,version: _dbversion,onCreate: _onCreate);
  }

  Future _onCreate(Database db,int version){
    db.execute(
      '''
      CREATE TABLE $_tableName(
      $Id INTEGER PRIMARY KEY,
      $name TEXT,
      $productId INTEGER,
      $sPrice DOUBLE,
      $aPrice DOUBLE,
      $vName TEXT,
      $varId STRING,
      $quantity DOUBLE,
      $availableQuantity DOUBLE,
      $imageUrl TEXT) 
      '''
    );
  }

  Future<int> insert(Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName,row);
  }

  Future<double>getTotalPrice()async{
    Database db = await instance.database;
    var totalPrice=0.0;
    var anyquery1 = await db.rawQuery("select * from $_tableName");
    for(int i=0;i<anyquery1.length;i++){
      totalPrice=totalPrice+(anyquery1[i]["productQuantity"]*anyquery1[i]["productSPrice"]);
    }
    print('totalPrice is :'+totalPrice.toString());
    return totalPrice;
  }

  Future<double>getQuantity(int pId,int vId)async{
    Database db = await instance.database;
    var quantity1=0.0;
    var anyquery = await db.rawQuery(
        "select * from $_tableName where $productId = $pId and $varId = $vId");
    if(anyquery.length!=0){
      quantity1=anyquery[0]["productQuantity"];
      print('quantity from db to details is:'+quantity1.toString());
      return quantity1;
    }
    return 0;
  }

  insertProductFromDetails(int id,int vId,double qty)async{
    Database db = await instance.database;
    var anyquery = await db.rawQuery(
        "select * from $_tableName where $productId = $id and $varId = $vId");

    if (anyquery.length != 0) {
      print('quantity is : ' + anyquery[0]["productQuantity"].toString());
      var newQuantity = anyquery[0]["productQuantity"]+qty;
      print('new qty : ' + newQuantity.toString());
      var availableQty = anyquery[0]["productAvailableQuantity"];

      if(newQuantity<=availableQty) {
        var check2 = await db.rawUpdate(
            '''UPDATE $_tableName SET productQuantity = ? WHERE _id = ? ''',
            [newQuantity, anyquery[0]["_id"]]);
        var anyquery1 = await db.rawQuery(
            "select * from $_tableName where $productId = $id and $varId = $vId");
        if (anyquery1.length != 0)
          print('updated quantity is : ' +
              anyquery1[0]["productQuantity"].toString());
        return check2;
      }
      return 0;
    }
  }

  insertProductInCart(int id,int vId,double qty) async {
    Database db = await instance.database;
    var anyquery = await db.rawQuery(
        "select * from $_tableName where $productId = $id and $varId = $vId");

    if (anyquery.length != 0) {
      print('quantity is : ' + anyquery[0]["productQuantity"].toString());
      var newQuantity = anyquery[0]["productQuantity"]+1;
      print('new qty : ' + newQuantity.toString());
        var check2 = await db.rawUpdate(
            '''UPDATE $_tableName SET productQuantity = ? WHERE _id = ? ''',
            [newQuantity, anyquery[0]["_id"]]);
      var anyquery1 = await db.rawQuery(
          "select * from $_tableName where $productId = $id and $varId = $vId");
      if (anyquery1.length != 0)
        print('updated quantity is : ' +
            anyquery1[0]["productQuantity"].toString());
        return check2;
    }
  }


  minusProductInCart(int id,int vId,double qty) async {
    Database db = await instance.database;
    var anyquery = await db.rawQuery(
        "select * from $_tableName where $productId = $id and $varId = $vId");

    if (anyquery.length != 0) {
      print('quantity is : ' + anyquery[0]["productQuantity"].toString());
      var newQuantity = anyquery[0]["productQuantity"] -1;
      print('new qty : ' + newQuantity.toString());
      var check2 = await db.rawUpdate(
          '''UPDATE $_tableName SET productQuantity = ? WHERE _id = ? ''',
          [newQuantity, anyquery[0]["_id"]]);
      var anyquery1 = await db.rawQuery(
          "select * from $_tableName where $productId = $id and $varId = $vId");
      if (anyquery1.length != 0)
        print('updated quantity is : ' +
            anyquery1[0]["productQuantity"].toString());
      return check2;
    }
  }




  insertProduct(int id,int vId,double qty,String vName,String imageUrl,String pName,double sPrice,double aPrice,double aQty)async{
    Database db = await instance.database;
    var anyquery=await db.rawQuery("select * from $_tableName where $productId = $id and $varId = $vId");

        if(anyquery.length!=0){
          print('quantity is : ' + anyquery[0]["productQuantity"].toString());

////      await db.rawQuery("SELECT * FROM $_tableName where $");
////    print(anyquery[0]);
    var newQuantity = anyquery[0]["productQuantity"]+qty;
    print('new qty : '+newQuantity.toString());
    var availableQty = anyquery[0]["productAvailableQuantity"];

    if(newQuantity<=availableQty){
      var check2 = await db.rawUpdate('''UPDATE $_tableName SET productQuantity = ? WHERE _id = ? ''',
          [newQuantity,anyquery[0]["_id"]]);
      var anyquery1=await db.rawQuery("select * from $_tableName where $productId = $id and $varId = $vId");
      if(anyquery1.length!=0)
        print('updated quantity is : ' + anyquery1[0]["productQuantity"].toString());

      return check2;
    }
////    var check1= db.rawQuery("select $quantity from $_tableName where $productId = $id and $varId = $vId");


    }else{
      var check3 = await DatabaseHelper.instance.insert({
        DatabaseHelper.name : pName,
        DatabaseHelper.productId : id,
        DatabaseHelper.sPrice :sPrice,
        DatabaseHelper.quantity :qty,
        DatabaseHelper.imageUrl :imageUrl,
        DatabaseHelper.aPrice :aPrice,
        DatabaseHelper.varId :vId,
        DatabaseHelper.vName :vName,
        DatabaseHelper.availableQuantity:aQty
      });
//      print('check3 value is'+check3.toString());
      return check3;

    }
    return 0;
  }

  Future<List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName,where: '$varId = ?',whereArgs: [id]);
  }

  Future<int> update(Map<String,dynamic>row) async{
    Database db = await instance.database;
    int id = row[Id];
    return await db.update(_tableName,row,where: '$productId = ?',whereArgs: [id]);

  }

   isPresent(int id,int vId) async{
    Database db = await instance.database;
    var anyquery=await db.rawQuery("select * from $_tableName where $productId = $id and $varId = $vId");
    print(anyquery);
    print('rohit ghodke');
    return anyquery.length!=0?true:false;
  }

  Future deleteAll() async{
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM $_tableName');
  }

  shoppingCartAddQty(){

  }

  shoppingCartDeleteQty(){

  }
}