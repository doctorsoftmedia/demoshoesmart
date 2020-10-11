
import 'package:flutter/material.dart';
import 'package:shoesmart/helper/database/DbCommand.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/model/SalesOrder.dart';

class ShoppingChartManagement extends ChangeNotifier
{
  static final ShoppingChartManagement _shoppingChartManagement = new ShoppingChartManagement._internal();
  factory ShoppingChartManagement()
  {
    return _shoppingChartManagement;
  }
  ShoppingChartManagement._internal();
  final String _tableSO = 'salesorder';
  final String _tableItem = 'item';
  final String _tableItemBrand = 'itembrand';
  // final String _tableItem = 'item';
  addToChart(SalesOrder row)async
  {
    int userpk = UserManagement().user.userpk;
    var data = await DbCommand().getListDataWhereArgs(_tableSO,where: 'itemfk = ? and userfk = ?',whereArgs: [row.itemfk,userpk]);
    if(data!=null && data.length>0)
    {
      var so = SalesOrder.fromJson(data.single);
      so.qty = so.qty+1;
      so.amount = so.qty * row.saleprice;
      //do update
      bool isSuccess = await DbCommand().update(_tableSO,'salesorderpk',so.salesorderpk,so.toJson());
      if(isSuccess)
      {
        getData();
      }
    }
    else
    {
      // do insert
      row.amount = row.qty * row.itemData.saleprice;
      bool isSuccess = await DbCommand().addNew(_tableSO, row.toJson());
      if(isSuccess)
      {
        getData();
      }
    }
  }
  
  updateRecord(SalesOrder so)async
  {
    so.amount = so.qty * so.itemData.saleprice;
    return await DbCommand().update(_tableSO,'salesorderpk',so.salesorderpk,so.toJson());
  }

  int get itemCountChart
  {
    int counterChart = 0;
    for (var item in salesorder) 
    {
      counterChart = counterChart+item.qty;
    }
    return counterChart;
  }

  int subTotalByBrand(SalesOrder so)
  {
    int subTotalBrand = 0;
    var res = salesorder.where((s)=>s.itemData.brandname == so.itemData.brandname);
    for (var item in res) 
    {
       subTotalBrand = subTotalBrand + item.amount;
    }
    return subTotalBrand;
  }
  int get grandTotalSalesOrder
  {
    int grandTotal = 0;
    for (var item in salesorder) 
    {
       grandTotal = grandTotal + item.amount;
    }
    return grandTotal;
  }
  List<SalesOrder> _salesorder = new List<SalesOrder>();
  set salesorder(List<SalesOrder> value)
  {
    _salesorder = value;
    notifyListeners();
  }
  List<SalesOrder> get salesorder => _salesorder;
  getData()async
  {
    
    int userpk = UserManagement().user.userpk;
    String qryGetItemFav = 'select a.*,b.*,c.* from $_tableSO a left join $_tableItem b on b.itempk = a.itemfk left join $_tableItemBrand c on c.itembrandpk = b.brandfk where a.userfk = $userpk';
    var result = await DbCommand().selectQuery(qryGetItemFav);
    if(result!=null && result.length>0)
    {
      salesorder = SalesOrder().listData(result);
    }
  }
}