import 'package:shoesmart/helper/database/DbCommand.dart';
import 'package:shoesmart/model/ItemBrand.dart';
import 'package:shoesmart/model/Wishlist.dart';

class Item {
  int itempk;
  String itemname;
  int saleprice;
  int brandfk;
  int itembrandpk;
  Wishlist wishlist;
  String brandname;
  Item({this.itempk, this.itemname, this.saleprice, this.brandfk,this.itembrandpk,this.brandname,this.wishlist});

  Item.fromJson(Map<String, dynamic> json) {
    itempk = json['itempk'];
    itemname = json['itemname'];
    saleprice = json['saleprice'];
    brandfk = json['brandfk'];
    itembrandpk = json['itembrandpk'];
    brandname = json['brandname'];
  }

  Map<String, dynamic> toJson() 
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['itempk'] = this.itempk;
    data['itemname'] = this.itemname;
    data['saleprice'] = this.saleprice;
    data['brandfk'] = this.brandfk;
    return data;
  }
  
  List<Item> listData(List jsons) 
  {
    List<Item> data = new List<Item>();
    for (var item in jsons) 
    {
      data.add(Item.fromJson(item));
    }
    return data;
  }
  initItem()async
  {
    var reuslt = await DbCommand().getListDataWhereArgs('itembrand');
    if(reuslt!=null && reuslt.length>0)
    {
      var reusltItem = await DbCommand().getListDataWhereArgs('item');
      if(reusltItem!=null && reusltItem.length>0)
        return;
      var jsonBrand = ItemBrand().listData(reuslt);
      for (var itembrand in jsonBrand) 
      {
        for (int i = 0; i < 5; i++) 
        {  
          var dateStr = DateTime.now().toString();
          var date = dateStr.substring(dateStr.length-5);
          int sales = int.tryParse(date);
          sales = i%2 == 0?sales*20:sales*50;
          var resultData = await DbCommand().addNew('item', Item(brandfk: itembrand.itembrandpk,itemname: 'Product $date',saleprice: sales ).toJson());
          print(resultData);
        }
      }
    }
  }
}
