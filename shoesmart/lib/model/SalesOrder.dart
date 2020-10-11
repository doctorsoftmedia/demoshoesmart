import 'package:shoesmart/model/Item.dart';

class SalesOrder 
{
  int salesorderpk;
  int itemfk;
  int qty;
  int saleprice;
  int amount;
  int userfk;
  Item itemData;
  SalesOrder(
      {this.salesorderpk, this.itemfk, this.qty, this.saleprice, this.amount,this.userfk,this.itemData});

  SalesOrder.fromJson(Map<String, dynamic> json) {
    salesorderpk = json['salesorderpk'];
    userfk = json['userfk'];
    itemfk = json['itemfk'];
    qty = json['qty'];
    saleprice = json['saleprice'];
    amount = json['amount'];
    itemData = json['itempk']!=null?
      Item.fromJson(json):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesorderpk'] = this.salesorderpk;
    data['userfk'] = this.userfk;
    data['itemfk'] = this.itemfk;
    data['qty'] = this.qty;
    data['saleprice'] = this.saleprice;
    data['amount'] = this.amount;
    return data;
  }
  List<SalesOrder> listData(List jsons) 
  {
    List<SalesOrder> data = new List<SalesOrder>();
    for (var item in jsons) 
    {
      data.add(SalesOrder.fromJson(item));
    }
    return data;
  }
}
