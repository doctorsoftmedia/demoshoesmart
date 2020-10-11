import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/helper/Helper.dart';
import 'package:shoesmart/management/NavMenuManagement.dart';
import 'package:shoesmart/management/ProductManagement.dart';
import 'package:shoesmart/management/ShoppingChartManagement.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/model/SalesOrder.dart';
import 'package:shoesmart/router/NavigationService.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageProductDetail extends StatefulWidget {
  @override
  _PageProductDetailState createState() => _PageProductDetailState();
}

class _PageProductDetailState extends State<PageProductDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<ProductManagement>(
      builder: (context, vwItem, child) {
        var row = vwItem.currentItem;
        return Scaffold(
          appBar: AppBar
          (
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
              NavMenuManagement().selectMenu = 0;
              NavigationService().goBack();
            }),
            title: CompText.text(label: row.itemname.toUpperCase()),
          ),
          body: Card(
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: Image.asset('assets/product/1.jpg')),
                  SizedBox(
                    height: 8,
                  ),Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CompText.text(
                          label: row.itemname, fontWeight: FontWeight.bold),
                      row.wishlist == null?Icon(Icons.favorite_border):Icon(Icons.favorite,
                                            color: Colors.redAccent,
                                          )
                    ],
                  ),
                  CompText.text(label: '${row.brandname}'),
                  SizedBox(
                    height: 8,
                  ),
                  CompText.text(
                      label: '${Helper().formatCurrency(row.saleprice)}'),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: ()async
          {
            var so = new SalesOrder(userfk: UserManagement().user.userpk,itemfk: row.itempk,qty: 1,saleprice: row.saleprice,amount: row.saleprice,itemData: row);
            await ShoppingChartManagement().addToChart(so);
            NavMenuManagement().selectMenu = 0;
            NavigationService().goBack();
          },child: Icon(Icons.shopping_cart,),),
        );
      },
    ));
  }
}
