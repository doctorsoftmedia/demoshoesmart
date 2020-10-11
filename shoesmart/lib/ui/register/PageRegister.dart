import 'package:flutter/material.dart';
import 'package:shoesmart/helper/Helper.dart';
import 'package:shoesmart/management/UserManagement.dart';
import 'package:shoesmart/model/UserModel.dart';
import 'package:shoesmart/ui/base/component/CompButton.dart';
import 'package:shoesmart/ui/base/component/CompDialog.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class PageRegister extends StatefulWidget 
{
  @override
  _PageRegisterState createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
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
              appBar: AppBar
              (
                title: CompText.text(label: 'Registrasi User'),
              ),
              body: Padding(padding: EdgeInsets.all(16),
              child:ListView(
                children: <Widget>
                [
                  SizedBox(height: 32,),
                  CompText.textFormField(
                    controller: usernameControll,
                    placeholder: 'Enter email',
                    labelText: 'E-Mail',
                    prefixIcon: Icon(Icons.perm_identity),
                    validator: (value) {
                      if (value.isEmpty) return 'Username masih kosong!';
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
                      label: 'Register',
                      onPress: () async {
                        if (!formKey.currentState.validate()) return;
                        //Do Register
                        var result = await UserManagement().register(UserModel(userid: usernameControll.text,password: passControll.text));
                        if(!result)
                        {
                          CompDialog.warningDialog(context, 'E-Mail sudah terdaftar!');
                          return;
                        }
                        Navigator.of(context).pop();
                      })
                ],
              )
              ),
            ),
            ));
  }
}