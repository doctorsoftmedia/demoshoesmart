
import 'package:flutter/material.dart';
import 'package:shoesmart/helper/database/DbCommand.dart';
import 'package:shoesmart/management/WishManagement.dart';
import 'package:shoesmart/model/Item.dart';
import 'package:shoesmart/model/Wishlist.dart';

class ProductManagement extends ChangeNotifier
{
  
  static final ProductManagement _productManagement = new ProductManagement._internal();
  factory ProductManagement()
  {
    return _productManagement;
  }
  final String _itemTable = 'item';
  final String _itembrand = 'itembrand';
  ProductManagement._internal();
  String _searchItem = '';
  String get searchItem  => _searchItem;
  set searchItem (String value)
  {
    _searchItem = value;
    notifyListeners();
  }

  List<Item> _itemList;
  List<Item> get itemList  => _itemList;
  set itemList (List<Item> value)
  {
    _itemList = value;
    notifyListeners();
  }

  Item _currentItem;
  Item get currentItem  => _currentItem;
  set currentItem (Item value)
  {
    _currentItem = value;
    notifyListeners();
  }

  Future<List<Item>> getData()async
  {
    String qryGetItem = 'select a.*,b.* from $_itemTable a left join $_itembrand b on b.itembrandpk = a.brandfk';
    List result = await DbCommand().selectQuery(qryGetItem);
    if(result!=null && result.length>0)
    {
      var resultData = Item().listData(result);
      if(searchItem.isNotEmpty)
      {
        var r = resultData.where((s)=>s.brandname.contains(searchItem)).toList();
        itemList = r;
      }
      else
      {
        itemList = resultData;
      }
    }
    else
       itemList = new List<Item>();
    compareFavLogic();
    return itemList;
  }

  Future compareFavLogic()async
  {
    var fav = WishManagement().wishlist;
    List<Item> itemtemp = itemList;
    if(itemtemp == null) return;
    for (var itemFav in fav) 
    {
      var index = itemtemp.indexWhere((s)=>s.itempk  == itemFav.itemfk);
      var data = itemtemp[index];
      data.wishlist = itemFav;
      itemtemp[index] = data;
    }
    itemList = itemtemp;
  }
  
  Future removeFavLogicRow(Wishlist row)async
  {
    List<Item> itemtemp = itemList;
    var index = itemtemp.indexWhere((s)=>s.itempk  == row.itemfk);
    var data = itemtemp[index];
    data.wishlist = null;
    itemtemp[index] = data;
    itemList = itemtemp;
  }
  
  
}