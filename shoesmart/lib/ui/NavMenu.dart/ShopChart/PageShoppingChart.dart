import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/helper/Helper.dart';
import 'package:shoesmart/management/ProductManagement.dart';
import 'package:shoesmart/management/ShoppingChartManagement.dart';
import 'package:shoesmart/router/NavigationService.dart';
import 'package:shoesmart/router/RouterPath.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageShoppingChart extends StatefulWidget {
  @override
  _PageShoppingChartState createState() => _PageShoppingChartState();
}

class _PageShoppingChartState extends State<PageShoppingChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingChartManagement>(
      builder: (context, vwChart, child) {
        return Scaffold(
            appBar: AppBar(
              title: CompText.text(label: 'Chart'),
            ),
            body: Padding(
                padding: EdgeInsets.all(8),
                child: vwChart.salesorder == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : vwChart.salesorder.length == 0
                        ? Center(
                            child: CompText.text(label: 'Tidak Ada Data!'),
                          )
                        :Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>
                          [
                            SizedBox(height: 8,),
                            CompText.text(label: 'Total Item : ${vwChart.itemCountChart}',fontSize: 24,fontWeight: FontWeight.bold),
                            SizedBox(height: 8,),
                            Flexible(child: generateContent(vwChart)),
                            SizedBox(height: 8,),
                            CompText.text(label: 'Grand Total : ${Helper().formatCurrency(vwChart.grandTotalSalesOrder)}',fontSize: 24,fontWeight: FontWeight.bold),
                            SizedBox(height: 8,),
                          ],
                        ) 
                        ));
      },
    );
  }

  generateContent(ShoppingChartManagement vwChart) 
  {
    return Padding(padding: EdgeInsets.all(8),child: ListView.builder
    (
        itemCount: vwChart.salesorder.length,
        itemBuilder: (context, index) 
        {
          bool isGenrateHeader = true;
          if(index>0)
          {
             isGenrateHeader = vwChart.salesorder[index].itemData.brandname == vwChart.salesorder[index-1].itemData.brandname?false:true;
          }
          var row = vwChart.salesorder[index];
          TextEditingController qtyController = new TextEditingController();
          qtyController.text = '${row.qty}';
          return Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              SizedBox(height: 8,),
              isGenrateHeader?
              Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>
                [
                  CompText.text(label: row.itemData.brandname.toUpperCase(),fontWeight: FontWeight.bold),
                  SizedBox(height: 8,),
                  CompText.text(label: 'Sub Total: ${Helper().formatCurrency(vwChart.subTotalByBrand(row))}',fontWeight: FontWeight.bold),
                  SizedBox(height: 8,),
                ],
              ):SizedBox(),
              GestureDetector(child: Card
              (
                elevation: 4.0,
                child: Padding(padding: EdgeInsets.all(8),child: Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>
                  [                  
                    SizedBox(height: 8,),
                    Image.asset('assets/product/1.jpg'),
                    SizedBox(height: 8,),
                    CompText.text(label: row.itemData.itemname),
                    SizedBox(height: 8,),
                    CompText.text(label: Helper().formatCurrency(row.itemData.saleprice)),
                    SizedBox(height: 8,),
                    CompText.textFormField(controller: qtyController,textInputType: TextInputType.number,labelText: 'Qty',textInputAction: TextInputAction.send,onSubmit: (value)
                    {
                      if(value!=null)
                      {
                        row.qty = int.tryParse(value);
                        ShoppingChartManagement().updateRecord(row);
                      }
                      return;
                    })
                  ],
                ),),
              ),onTap: ()
              {
                ProductManagement().currentItem = row.itemData;
                NavigationService().navigateTo(RoutePath.ProductDetailRoute);
              },
              )
            ],
          );
        }),);
  }
}
