
import 'package:flutter/material.dart';
import 'package:shoesmart/helper/database/DbCommand.dart';
import 'package:shoesmart/management/ProductManagement.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/model/Item.dart';
import 'package:shoesmart/model/Wishlist.dart';

class WishManagement extends ChangeNotifier
{
  static final WishManagement _wishManagement = new WishManagement._internal();
  factory WishManagement()
  {
    return _wishManagement;
  }
  WishManagement._internal();
  final String _tableWishlist = 'wishlist';
  final String _tableItem = 'item';
  final String _tableItemBrand = 'itembrand';
  
  int _counterFav = 0;
  set counterFav(int value)
  {
    _counterFav = value;
    notifyListeners();
  }
  int get counterFav => _counterFav;

  List<Wishlist> _wishlist = new List<Wishlist>();
  set wishlist(List<Wishlist> value)
  {
    _wishlist = value;
    notifyListeners();
  }
  List<Wishlist> get wishlist => _wishlist;

  addToFavorite(Item row)async
  {
    int userfk = UserManagement().user.userpk;
    var data = await DbCommand().getListDataWhereArgs(_tableWishlist,where: 'itemfk = ? and userfk = ?',whereArgs: [row.itempk,userfk]);
    if(data == null || data.length == 0)
    {
      //then add to favorite
      Wishlist wish = new Wishlist(itemfk: row.itempk,userfk:userfk );
      bool isSuccess = await DbCommand().addNew(_tableWishlist, wish.toJson());
      if(isSuccess)
      {
        getFavoriteList();
      }
    }
  }
  
  unFavorite(Wishlist row)async
  {
    bool isSuccess = await DbCommand().delete(_tableWishlist,'wishlistpk',row.wishlistpk);
    if(isSuccess)
    {
      getFavoriteList();
      ProductManagement().removeFavLogicRow(row);
    }
  }
  
  Future getCounterFav()async
  {
    int userfk = UserManagement().user.userpk;
    var result = await DbCommand().getListDataWhereArgs(_tableWishlist,where: 'userfk = ?',whereArgs: [userfk]);
    counterFav = result.length;
  }

  Future getFavoriteList()async
  {
    int userfk = UserManagement().user.userpk;
    // String qryGetItemFav = 'select a.*,b.* from $_tableWishlist a left join $_tableItem b on b.itempk = a.itemfk where a.userfk = $userfk';
    String qryGetItemFav = 'select a.*,b.*,c.* from $_tableWishlist a left join $_tableItem b on b.itempk = a.itemfk left join $_tableItemBrand c on c.itembrandpk = b.brandfk where a.userfk = $userfk';

    var result = await DbCommand().selectQuery(qryGetItemFav);
    if(result!=null && result.length>0)
    {
      wishlist = Wishlist().listData(result);
    }
    else
    {
      wishlist = new List<Wishlist>();
    }
    getCounterFav();
    ProductManagement().compareFavLogic();
  }
  
}