import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/management/NavMenuManagement.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/ui/NavMenu.dart/Account/PageAccount.dart';
import 'package:shoesmart/ui/NavMenu.dart/Home/PageProductList.dart';
import 'package:shoesmart/ui/NavMenu.dart/wish/IconWishlistCounter.dart';
import 'package:shoesmart/ui/NavMenu.dart/wish/PageWishlist.dart';
import 'package:shoesmart/ui/base/component/CompDialog.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';
import 'package:shoesmart/ui/base/constanta/ConstColor.dart';

class PageNavMenu extends StatefulWidget 
{
  @override
  _PageNavMenuState createState() => _PageNavMenuState();
}

class _PageNavMenuState extends State<PageNavMenu> 
{
  final widgetScreen = [PageProductList(),PageWishList(),PageAccount()];
  @override
  Widget build(BuildContext context) {
    return SafeArea
    (
      child: Consumer<NavMenuManagement>
      (
        builder: (context,vwNav,child)
        {
          return WillPopScope(child: Scaffold
          (
            body:IndexedStack
            (
              children: <Widget>[widgetScreen.elementAt(vwNav.selectMenu)],
            ),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 4,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>
                [
                  BottomNavigationBarItem(icon: Icon(Icons.home), title: CompText.text(label: 'Home')),
                  BottomNavigationBarItem(icon: IconWishListCounter(), title: CompText.text(label: 'Favorite')),
                  BottomNavigationBarItem(icon: Icon(Icons.person), title: CompText.text(label: 'Account'))
                ],
                currentIndex: vwNav.selectMenu,
                fixedColor: ConstColor.colorButton,
                onTap: (index)
                {
                  vwNav.selectMenu = index;
                },
              ),
          ),
        ), onWillPop: ()async
        {
          await CompDialog.confirmDialog(context, 'Logout', 'Keluar Aplikasi', ()
          {
            UserManagement().logout();
          });
          return false;
        });
        },
      )
      );
  }
}