
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/management/WishManagement.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class IconWishListCounter extends StatefulWidget {
  @override
  _IconWishListCounterState createState() => _IconWishListCounterState();
}

class _IconWishListCounterState extends State<IconWishListCounter> 
{
  @override
  Widget build(BuildContext context) {
    return Consumer<WishManagement>
        (
          builder: (context,vwWish,_)
          {
            return Stack(
                children: <Widget>[
                  Icon(Icons.favorite,size: 24,),
                  vwWish.counterFav>0?Positioned(
                      right: 0,
                      child: CircleAvatar(
                        minRadius: 8,
                        backgroundColor: Colors.red,
                        child:CompText.text(label: '${vwWish.counterFav}',fontWeight: FontWeight.bold,fontSize: 8),
                      ),
                    ):SizedBox(height: 3,)
                ],
              );
          },
        );

  }
}
