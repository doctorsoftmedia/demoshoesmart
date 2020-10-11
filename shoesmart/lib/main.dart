import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/management/NavMenuManagement.dart';
import 'package:shoesmart/management/ProductManagement.dart';
import 'package:shoesmart/management/ShoppingChartManagement.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/management/WishManagement.dart';
import 'package:shoesmart/router/NavigationService.dart';
import 'package:shoesmart/router/RoutePage.dart';
import 'package:shoesmart/router/RouterPath.dart';
import 'package:shoesmart/ui/base/constanta/ConstColor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [
      ChangeNotifierProvider(create: (context)=>UserManagement()),
      ChangeNotifierProvider(create: (context)=>NavMenuManagement()),
      ChangeNotifierProvider(create: (context)=>ProductManagement()),
      ChangeNotifierProvider(create: (context)=>ShoppingChartManagement()),
      ChangeNotifierProvider(create: (context)=>WishManagement()),
    ],
    child: MaterialApp(
      title: 'Shoesmart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData
      ( 
        appBarTheme: AppBarTheme
        (
          color: ConstColor.colorAppBar
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData
        (
          backgroundColor: ConstColor.colorButton
        )
      ),
      onGenerateRoute: RoutePage.generateRoute,
      initialRoute: RoutePath.SplashScreenRoute,
      navigatorKey: NavigationService().navigatorKey,
    ),
    );
  }
}
