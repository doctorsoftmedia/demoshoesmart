import 'package:shoesmart/model/Item.dart';

class Wishlist {
  int wishlistpk;
  int itemfk;
  int userfk;
  Item itemData;
  Wishlist({this.wishlistpk, this.itemfk,this.userfk,this.itemData});

  Wishlist.fromJson(Map<String, dynamic> json) 
  {
    wishlistpk = json['wishlistpk'];
    itemfk = json['itemfk'];
    userfk = json['userfk'];
    itemData = json['itempk']!=null?
      Item.fromJson(json):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wishlistpk'] = this.wishlistpk;
    data['itemfk'] = this.itemfk;
    data['userfk'] = this.userfk;
    return data;
  }
  List<Wishlist> listData(List jsons) 
  {
    List<Wishlist> data = new List<Wishlist>();
    for (var item in jsons) 
    {
      data.add(Wishlist.fromJson(item));
    }
    return data;
  }
}
