
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/management/ShoppingChartManagement.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class IconChartCounter extends StatefulWidget {
  @override
  _IconChartCounterState createState() => _IconChartCounterState();
}

class _IconChartCounterState extends State<IconChartCounter> 
{
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingChartManagement>
        (
          builder: (context,vw,_)
          {
            return Stack(
                children: <Widget>[
                  Icon(Icons.shopping_cart,size: 24,),
                  vw.salesorder!= null && vw.salesorder.length >0?Positioned(
                      right: 0,
                      child: CircleAvatar(
                        minRadius: 8,
                        backgroundColor: Colors.red,
                        child:CompText.text(label: '${vw.salesorder.length}',fontWeight: FontWeight.bold,fontSize: 8),
                      ),
                    ):SizedBox(height: 3,)
                ],
              );
          },
        );

  }
}
