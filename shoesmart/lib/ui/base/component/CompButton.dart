import 'package:flutter/material.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';
import 'package:shoesmart/ui/base/constanta/ConstColor.dart';

class CompButton
{
  static Widget buttonPrimary({String label:'-',VoidCallback onPress, 
  Color colorBackground:ConstColor.colorButton,
  Color colorText:Colors.white,
  double fontSize:16,double circle:8})
  {
    return FlatButton
    (
      color: colorBackground,
      shape: RoundedRectangleBorder( borderRadius: new BorderRadius.circular(circle) ),
      child: CompText.text(label: label,color: colorText,fontSize: fontSize),
      onPressed: onPress,
    );
  }

}