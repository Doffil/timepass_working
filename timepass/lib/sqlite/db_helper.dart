import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timepass/Model.dart';

class DatabaseHelper{
  static final _dbName = 'myDatabase.db';
  static final _dbversion = 1;
  static final _tableName = 'Products';
  static final columnId = '_id';
  static final columnSubId = 'subId';
  static final columnName = 'subName';
  static final columnPrice = 'subPrice';
  static final columnQuantity = 'subQuantity';
  static final columnImageUrl = 'subImageUrl';

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
      $columnId INTEGER PRIMARY KEY,
      $columnName TEXT,
      $columnSubId INTEGER,
      $columnPrice INTEGER,
      $columnQuantity INTEGER,
      $columnImageUrl TEXT) 
      '''
    );
  }

  Future<int> insert(Map<String,dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName,row);
  }

  Future<List<Map<String,dynamic>>> queryAll() async{
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> delete(int id) async{
    Database db = await instance.database;
    return await db.delete(_tableName,where: '$columnSubId = ?',whereArgs: [id]);
  }


  Future deleteAll() async{
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM $_tableName');
  }
}