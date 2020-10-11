import 'package:flutter/material.dart';
import 'package:shoesmart/router/RouterPath.dart';

class NavigationService {
  static final NavigationService _navigationService = new NavigationService._internal();
  factory NavigationService()
  {
    return _navigationService;
  }
  NavigationService._internal();
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName,{arguments}) 
  {
    return navigatorKey.currentState.pushNamed(routeName,arguments: arguments);
  }
  Future<dynamic> navigateAndRemoveTo(String routeName) 
  {
    //
      //   Navigator.pushReplacementNamed(context, routes.LoginRoute);
    return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
    // return navigatorKey.currentState.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
  Future<dynamic> navigateLogin() {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(RoutePath.LoginRoute, (Route<dynamic> route) => false);
  }
  bool goBack() {
    return navigatorKey.currentState.pop();
  }
}