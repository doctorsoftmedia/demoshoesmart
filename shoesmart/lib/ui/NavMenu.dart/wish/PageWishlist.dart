import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/helper/Helper.dart';
import 'package:shoesmart/management/ProductManagement.dart';
import 'package:shoesmart/management/WishManagement.dart';
import 'package:shoesmart/router/NavigationService.dart';
import 'package:shoesmart/router/RouterPath.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageWishList extends StatefulWidget {
  @override
  _PageWishListState createState() => _PageWishListState();
}

class _PageWishListState extends State<PageWishList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WishManagement>(
      builder: (context, vwWish, child) {
        return Scaffold(
            appBar: AppBar(
              title: CompText.text(label: 'Favorite'),
            ),
            body: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CompText.text(
                      label:
                          'TOTAL : ${vwWish.wishlist == null ? 0 : vwWish.wishlist.length}',
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  SizedBox(
                    height: 8,
                  ),
                  vwWish.wishlist == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : vwWish.wishlist.length == 0
                          ? Center(
                              child: CompText.text(label: 'Tidak Ada Data!'),
                            )
                          : Flexible(child: generateContent(vwWish))
                ],
              ),
            ));
      },
    );
  }

  generateContent(WishManagement vwWish) {
    return RefreshIndicator(
        child: GridView.builder(
            itemCount: vwWish.wishlist.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              var row = vwWish.wishlist[index];
              return GestureDetector(
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset('assets/product/1.jpg'),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CompText.text(
                                label: row.itemData.itemname,
                                fontWeight: FontWeight.bold),
                            IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  vwWish.unFavorite(row);
                                })
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CompText.text(label: '${row.itemData.brandname}'),
                        SizedBox(
                          height: 8,
                        ),
                        CompText.text(
                            label:
                                '${Helper().formatCurrency(row.itemData.saleprice)}'),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  ProductManagement().currentItem = row.itemData;
                  NavigationService().navigateTo(RoutePath.ProductDetailRoute);
                },
              );
            }),
        onRefresh: vwWish.getFavoriteList);
  }
}
