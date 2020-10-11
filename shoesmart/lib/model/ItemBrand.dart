import 'package:shoesmart/helper/database/DbCommand.dart';

class ItemBrand {
  int itembrandpk;
  String brandname;

  ItemBrand({this.itembrandpk, this.brandname});

  ItemBrand.fromJson(Map<String, dynamic> json) {
    itembrandpk = json['itembrandpk'];
    brandname = json['brandname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['itembrandpk'] = this.itembrandpk;
    data['brandname'] = this.brandname;
    return data;
  }
  
  List<ItemBrand> listData(List jsons) 
  {
    List<ItemBrand> data = new List<ItemBrand>();
    for (var item in jsons) 
    {
      data.add(ItemBrand.fromJson(item));
    }
    return data;
  }
  initBrand()async
  {
    var reuslt = await DbCommand().getListDataWhereArgs('itembrand');
    if(reuslt == null || reuslt.length == 0)
    {
      //then do init data
      for (var i = 0; i < 5; i++) 
      {
        var add = await DbCommand().addNew('itembrand', ItemBrand(brandname: 'Brand Product-$i').toJson());
        print(add);
      } 
    }
  }
}
