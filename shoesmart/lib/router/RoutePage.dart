import 'package:flutter/material.dart';
import 'package:shoesmart/router/RouterPath.dart';
import 'package:shoesmart/ui/NavMenu.dart/Home/PageProductDetail.dart';
import 'package:shoesmart/ui/NavMenu.dart/PageNavMenu.dart';
import 'package:shoesmart/ui/NavMenu.dart/ShopChart/PageShoppingChart.dart';
import 'package:shoesmart/ui/PageLogin.dart';
import 'package:shoesmart/ui/PageSplashScreen.dart';
import 'package:shoesmart/ui/register/PageRegister.dart';

class RoutePage
{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) 
    {
      case RoutePath.SplashScreenRoute:
        return MaterialPageRoute(builder: (context) => PageSplashScreen());
      case RoutePath.LoginRoute:
        return MaterialPageRoute(builder: (context) => PageLogin());
      case RoutePath.RegisterRoute:
        return MaterialPageRoute(builder: (context) => PageRegister());
      case RoutePath.NavMenuRoute:
        return MaterialPageRoute(builder: (context) => PageNavMenu());
      case RoutePath.ProductDetailRoute:
        return MaterialPageRoute(builder: (context) => PageProductDetail());
      case RoutePath.ShoppingChartRoute:
        return MaterialPageRoute(builder: (context) => PageShoppingChart());
      default:
        return exceptionPath('No Path ${settings.name}');
    }
  }

  static exceptionPath(String info) {
    return MaterialPageRoute(
        builder: (context) => SafeArea(
                child: Scaffold(
              body: Center(
                child: Text('$info'),
              ),
            )));
  }

}