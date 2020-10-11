import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/helper/Helper.dart';
import 'package:shoesmart/management/ProductManagement.dart';
import 'package:shoesmart/management/WishManagement.dart';
import 'package:shoesmart/router/NavigationService.dart';
import 'package:shoesmart/router/RouterPath.dart';
import 'package:shoesmart/ui/NavMenu.dart/ShopChart/IconChartCounter.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageProductList extends StatefulWidget {
  @override
  _PageProductListState createState() => _PageProductListState();
}

class _PageProductListState extends State<PageProductList> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() 
  {
    super.initState();
    Future.delayed(Duration.zero,
    (){
      searchController.text = ProductManagement().searchItem;
    });
  }
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductManagement>(
      builder: (context, vwItem, child) {
        return Scaffold(
          appBar: AppBar
          (
            automaticallyImplyLeading: false,
            title: Container
            (
              child: CompText.textFormField(controller: searchController,padding: EdgeInsets.all(10),onSubmit: (value)
              {
                ProductManagement().searchItem = value;
                ProductManagement().getData();
                return;
              }),
              color: Colors.white,
            ),
            actions: <Widget>
            [
              IconButton(icon: IconChartCounter(), 
              onPressed: ()
              {
                NavigationService().navigateTo(RoutePath.ShoppingChartRoute);
              })
            ],
          ),
          body: vwItem.itemList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : vwItem.itemList.length == 0
                  ? Center(
                      child: CompText.text(label: 'Data tidak ada!'),
                    )
                  : RefreshIndicator(child: GridView.builder(
                      itemCount: vwItem.itemList.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        var row = vwItem.itemList[index];
                        return GestureDetector(
                          child: Card(
                            elevation: 4.0,
                            child: Padding(
                              padding: EdgeInsets.all(6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child:
                                          Image.asset('assets/product/1.jpg')),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      CompText.text(
                                          label: row.itemname,
                                          fontWeight: FontWeight.bold),
                                      IconButton(
                                          icon: row.wishlist == null?Icon(Icons.favorite_border):Icon(Icons.favorite,
                                            color: Colors.redAccent,
                                          ),
                                          onPressed: () async {
                                            WishManagement().addToFavorite(row);
                                          })
                                    ],
                                  )),
                                  CompText.text(label: '${row.brandname}'),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  CompText.text(
                                      label:
                                          '${Helper().formatCurrency(row.saleprice)}'),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            vwItem.currentItem = row;
                            NavigationService()
                                .navigateTo(RoutePath.ProductDetailRoute);
                          },
                        );
                      }), onRefresh: vwItem.getData),
        );
      },
    );
  }
}
