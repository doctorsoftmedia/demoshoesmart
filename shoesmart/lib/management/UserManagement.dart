import 'package:flutter/cupertino.dart';
import 'package:shoesmart/helper/database/DbCommand.dart';
import 'package:shoesmart/management/ProductManagement.dart';
import 'package:shoesmart/management/ShoppingChartManagement.dart';
import 'package:shoesmart/management/WishManagement.dart';
import 'package:shoesmart/model/UserModel.dart';
import 'package:shoesmart/router/NavigationService.dart';

class UserManagement extends ChangeNotifier
{

  static final UserManagement _userManagement = new UserManagement._internal();
  factory UserManagement()
  {
    return _userManagement;
  }
  UserManagement._internal();
  Future<bool> register(UserModel user)async
  {
    String table = 'user';
    //check data
    var isExist = await DbCommand().isExist(table,where: 'userid = ?',whereArgs: [user.userid]);
    if(!isExist)
    {
      //register
      var result = await DbCommand().addNew(table, user.toJson());
      return result;
    }
    return !isExist;
  }
  UserModel _user;
  set user(UserModel value)
  {
    _user = value;
    notifyListeners();
  }
  UserModel get user => _user;

  Future<bool> login(UserModel value)async
  {
    String table = 'user';
    //check data
    var result = await DbCommand().getListDataWhereArgs(table,where: 'userid = ? and password = ?',whereArgs: [value.userid,value.password]);
    if(result == null || result.length == 0)
    return false;
    this.user = UserModel.fromJson(result.single);
    await WishManagement().getFavoriteList();
    await ProductManagement().getData();
    await ShoppingChartManagement().getData();
    return true;
  }
  
  logout()
  {
    NavigationService().navigateLogin();
    user = null;
  }
}