import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/model/UserModel.dart';
import 'package:shoesmart/ui/base/component/CompDialog.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageAccount extends StatefulWidget {
  @override
  _PageAccountState createState() => _PageAccountState();
}

class _PageAccountState extends State<PageAccount> {
  @override
  Widget build(BuildContext context) 
  {
    return Consumer<UserManagement>(builder: (context, vwAccount, child) 
    {
      var row = vwAccount.user??new UserModel();
      return Scaffold(
        appBar: AppBar(
          title: CompText.text(label: 'Account'),
        ),
        body: Column(
          children: <Widget>
          [
            ListTile
            (
              title: CompText.text(label: 'User ID'),
              subtitle: CompText.text(label: row.userid),
            ),
            SizedBox(height: 6,),
            ListTile
            (
              title: CompText.text(label: 'ABOUT',fontWeight: FontWeight.bold),
            ),
            ListTile
            (
              title: CompText.text(label: 'Software Developer'),
              subtitle:CompText.text(label: 'This apps Created By Lukman Harun for development testing'),
            ),
            ListTile
            (
              leading: Icon(Icons.exit_to_app),
              title: CompText.text(label: 'LOGOUT'),
              onTap: ()
              {
                CompDialog.confirmDialog(context, 'Log Out', 'Keluar Aplikasi?', ()
                {
                  vwAccount.logout();
                }
                );
              },
            )
          ],
        ),
      );
    });
  }
}
