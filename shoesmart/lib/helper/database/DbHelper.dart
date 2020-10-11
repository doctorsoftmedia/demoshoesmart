import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper
{
  
  static final DbHelper _dbHelper = new DbHelper._internal();
  factory DbHelper()
  {
    return _dbHelper;
  }
  DbHelper._internal();
  
  static Database _db;
  int dbVersion = 1;
  String dbName = 'dbdemo.db';
  Future<Database> get db async
  {
    if(_db==null){
      _db = await initDB();
      return _db;
    }
    return _db;
  } 
  initDB() async {
    Directory dirDoc = await getApplicationDocumentsDirectory();
    String path = join(dirDoc.path,dbName);
    var ourDB = await openDatabase(path,version: dbVersion,onCreate: onCreateDB,onUpgrade: onUpgrade);
    return ourDB;
  }
  
  Future<void> onUpgrade(Database db,int oldVersion,int newVersion)async{
  }

  void onCreateDB(Database db, int version) async
  {
    //create table
    await db.execute('CREATE TABLE "user" ( "userpk" INTEGER NOT NULL, "userid" TEXT NOT NULL UNIQUE, "password" TEXT NOT NULL, PRIMARY KEY("userpk" AUTOINCREMENT) )');
    await db.execute('CREATE TABLE "itembrand" ( "itembrandpk" INTEGER, "brandname" TEXT NOT NULL UNIQUE, PRIMARY KEY("itembrandpk" AUTOINCREMENT) )');
    await db.execute('CREATE TABLE "item" ( "itempk" INTEGER, "itemname" TEXT NOT NULL, "saleprice" NUMERIC NOT NULL DEFAULT 0, "brandfk" INTEGER NOT NULL, FOREIGN KEY("brandfk") REFERENCES "itembrand"("itembrandpk"), PRIMARY KEY("itempk" AUTOINCREMENT) )');
    await db.execute('CREATE TABLE "wishlist" ( "wishlistpk" INTEGER, "itemfk" INTEGER NOT NULL, "userfk" INTEGER NOT NULL, PRIMARY KEY("wishlistpk" AUTOINCREMENT), FOREIGN KEY("itemfk") REFERENCES "item"("itempk"),FOREIGN KEY("userfk") REFERENCES "user"("userpk") ) ');
    await db.execute('CREATE TABLE "salesorder" ( "salesorderpk" INTEGER, "itemfk" INTEGER NOT NULL,"userfk" INTEGER NOT NULL, "qty" INTEGER NOT NULL DEFAULT 0, "saleprice" NUMERIC NOT NULL DEFAULT 0, "amount" NUMERIC NOT NULL DEFAULT 0, FOREIGN KEY("itemfk") REFERENCES "item"("itempk"), FOREIGN KEY("userfk") REFERENCES "user"("userpk"), PRIMARY KEY("salesorderpk" AUTOINCREMENT) )'); 
  
  }

}