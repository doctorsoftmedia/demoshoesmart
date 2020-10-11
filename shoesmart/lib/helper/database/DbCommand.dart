
import 'package:shoesmart/helper/database/DbHelper.dart';

class DbCommand
{
  static final DbCommand _dbCommand = new DbCommand._internal();
  factory DbCommand()
  {
    return _dbCommand;
  }
  DbCommand._internal();

  Future<bool> addNew(String table,Map<String, Object> row)async
  {
    try
    {
      var db = await DbHelper().db;
      var result = await db.insert(table, row);
      return result>0?true:false;
    }catch(e)
    {
      print(e);
      return false;
    }
  }
  Future<bool> update(String table,String pkName,int pkValue,Map<String, Object> row)async
  {
    try
    {
      var db = await DbHelper().db;
      var result = await db.update(table, row,where: '$pkName = ?',whereArgs: [pkValue]);
      return result>0?true:false;
    }catch(e)
    {
      print(e);
      return false;
    }
  }
  Future<bool> delete(String table,String pkName,int pkValue)async
  {
    try{
      var db = await DbHelper().db;
      var result = await db.delete(table, where: '$pkName = ?',whereArgs: [pkValue]);
      return result>0?true:false;
    }catch(e)
    {
      print(e);
      return false;
    }
  }
  Future<bool> isExist(String table,{String where,List whereArgs}) async{
    try{
      var db = await DbHelper().db;
      var result = await db.query(table,where:where,whereArgs: whereArgs);
      return result.length == 0?false:true;
    }catch(e)
    {
      print(e);
      return false;
    }
  }
  Future<List<Map<String,dynamic>>> getListDataWhereArgs(String table,{String where,List whereArgs})async{
    try{
      var db = await DbHelper().db;
      List<Map<String,dynamic>> result =  await db.query(table,where: where,whereArgs: whereArgs);
      return result;
    }catch(e)
    {
      print(e);
      return null;
    }
  }
  Future<List<Map<String,dynamic>>> selectQuery(String query)async{
    try{
      var db = await DbHelper().db;
      var result = await db.rawQuery(query);
      return result;
    }catch(e)
    {
      print(e);
      return null;
    }
  }
  
}