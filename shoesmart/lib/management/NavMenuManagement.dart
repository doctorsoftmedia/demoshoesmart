import 'package:flutter/cupertino.dart';

class NavMenuManagement extends ChangeNotifier
{
  static final NavMenuManagement _navMenuManagement = new NavMenuManagement._internal();
  factory NavMenuManagement()
  {
    return _navMenuManagement;
  }
  NavMenuManagement._internal();
  int _selectMenu = 0;
  set selectMenu (int value)
  {
    _selectMenu = value;
    notifyListeners();
  }
  int get selectMenu => _selectMenu;
  
}