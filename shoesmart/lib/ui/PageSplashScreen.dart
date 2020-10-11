import 'package:flutter/material.dart';
import 'package:shoesmart/model/Item.dart';
import 'package:shoesmart/model/ItemBrand.dart';
import 'package:shoesmart/router/NavigationService.dart';
import 'package:shoesmart/router/RouterPath.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageSplashScreen extends StatefulWidget 
{
  @override
  _PageSplashScreenState createState() => _PageSplashScreenState();
}

class _PageSplashScreenState extends State<PageSplashScreen> 
{
  @override
  void initState() 
  {
    super.initState();
    Future.delayed(Duration.zero,()async
    {
      // init Data
      await ItemBrand().initBrand();
      await Item().initItem();  
      NavigationService().navigateAndRemoveTo(RoutePath.LoginRoute);
    });
  }
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea
    (
      child: Scaffold
      (
        body: Center(
      child: CompText.text(label: 'Loading Screen'),
    ),
      )
    
    );
  }
}