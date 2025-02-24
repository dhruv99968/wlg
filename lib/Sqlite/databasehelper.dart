import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wlg/modelClass/user.dart';
class DatabaseHelper {
  //private and global cant assign again
  static final DatabaseHelper instance = DatabaseHelper._instance();
  DatabaseHelper._instance();
  static Database? _database;
  //check database is created or not
  //if not then create... new database
  Future<Database> get db async {
    // null , init..
    _database ??= await initDb();
    //return  not null database
    return _database!;
  }
  //creating database
  Future<Database> initDb() async {
    //databasepathe give as to local file path in device
    String databasesPath = await getDatabasesPath();
    //path of android or ios device
    //and with name(wlg.db) create custom new database
    //.db is not required
    String path = join(databasesPath, 'wlg.db');
    return await openDatabase(path, version: 1, onCreate: (db,version) async {
      await db.execute('''
      CREATE TABLE wlg_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT
      )
    ''');
    });
  }
/*//Create a new table on above path
  Future _onCreate(Database databaseTable, int version) async {
     await databaseTable.execute('''
      CREATE TABLE wlg_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        password TEXT
      )
    ''');
  }*/
/*
  Future<int> insertUser(String em,String ps) async {
    User user = User(email:em, password: ps);
    print(user.toMap());
    Database db = await instance.db;
   return await db.insert('wlg_table', user.toMap());
   // return await db.insert('wlg_table', {'email': em, 'password': ps,});
  }
*/
  Future<int> insertUser(User user) async {
    // User user = User(email:em, password: ps);
    print(user.toMap());
    Database db = await instance.db;
    return await db.insert('wlg_table', user.toMap());
    // return await db.insert('wlg_table', {'email': em, 'password': ps,});
  }
  Future<List<Map<String, dynamic>>> getData()async{
    Database db =await instance.db;
    List<Map<String,dynamic>> ds = await db.query('wlg_table');
    print(ds);
    return ds;
  }
  Future<int> updateUser(index,String email,String password) async {
     User user = User(email:email, password: password);
     List<Map<String, dynamic>> dbs = await getData() ;
     //index++;
     String e =dbs[index]['email'];
    // String p =dbs[id]['password'];
  //  print(user.toMap());
     print(e);
    Database db = await instance.db;
    return await db.update('wlg_table', user.toMap(),where: 'email = ?',whereArgs: [e]);
    // return await db.insert('wlg_table', {'email': em, 'password': ps,});

  }
  Future<int> deleteUser(int index) async {
    List<Map<String, dynamic>> dbs = await getData() ;

    int  e =dbs[index]['id'];
    // String p =dbs[id]['password'];

    print(e);
    Database db = await instance.db;
    return await db.delete('wlg_table',where: 'id = ?',whereArgs: [e]);
    // return await db.insert('wlg_table', {'email': em, 'password': ps,});
  }
}