import 'package:flutter/material.dart';
import 'package:shoesmart/helper/Helper.dart';
import 'package:shoesmart/management/NavMenuManagement.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/model/UserModel.dart';
import 'package:shoesmart/router/NavigationService.dart';
import 'package:shoesmart/router/RouterPath.dart';
import 'package:shoesmart/ui/base/component/CompButton.dart';
import 'package:shoesmart/ui/base/component/CompDialog.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController usernameControll = new TextEditingController();
  TextEditingController passControll = new TextEditingController();
  bool isPassHidden;
  @override
  void initState() {
    super.initState();
    isPassHidden = true;
  }

  @override
  void dispose() {
    super.dispose();
    usernameControll.dispose();
    passControll.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
            key: formKey,
            child: Scaffold(
              body: Padding(padding: EdgeInsets.all(8),
              child: Center(
                child: ListView(
                shrinkWrap: true,
                children: <Widget>
                [
                  CompText.text(label: 'WELCOME TO APPS',textAlign: TextAlign.center),
                  SizedBox(height: 32,),
                  CompText.textFormField(
                    controller: usernameControll,
                    placeholder: 'Enter email',
                    labelText: 'E-Mail',
                    prefixIcon: Icon(Icons.perm_identity),
                    validator: (value) {
                      if (value.isEmpty) return 'E-Mail masih kosong!';
                      if(!Helper.validateEmail(value))
                        return 'E-mail tidak sesuai!';
                      return null;
                    },
                  ),
                  SizedBox(height: 8,),
                  CompText.textFormField(
                    controller: passControll,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    isObsecure: isPassHidden,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: isPassHidden ? Colors.grey : Colors.orange,
                      ),
                      onPressed: () async {
                        setState(() {
                          isPassHidden = !isPassHidden;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Password masih kosong!';
                      return null;
                    },
                  ),
                  SizedBox(height: 8,),
                  CompButton.buttonPrimary(
                      label: 'LOGIN',
                      onPress: () async {
                        if (!formKey.currentState.validate()) return;
                        var result = await UserManagement().login(UserModel(userid: usernameControll.text,password: passControll.text));
                        if(!result)
                        {
                          CompDialog.warningDialog(context, 'User Id atau Password tidak sesuai!');
                          return;
                        }
                        else
                        {
                          NavMenuManagement().selectMenu = 0;
                          NavigationService().navigateAndRemoveTo(RoutePath.NavMenuRoute);
                        }
                      })
                ],
              )
              ),),
              floatingActionButton: CompButton.buttonPrimary(label: 'Register',onPress: ()async
                {
                  NavigationService().navigateTo(RoutePath.RegisterRoute);
                })
            ),
            ));
  }
}
