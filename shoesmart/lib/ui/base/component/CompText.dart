import 'package:flutter/material.dart';

class CompText
{
  static Widget text({String label:'-',Color color,double fontSize,TextAlign textAlign,FontWeight fontWeight})
  {
    return Text(label,
    style: TextStyle
    (
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight
    ),
    textAlign: textAlign,
    );
  }
  
static TextFormField textFormField({TextEditingController controller,bool isObsecure:false,String labelText,Icon prefixIcon,
Widget suffixIcon,String validator(String value),TextInputType textInputType,String placeholder,
bool isReadOnly:false,VoidCallback onTap,InputBorder inputBorder:const OutlineInputBorder(),EdgeInsetsGeometry padding,
int maxLine:1,TextInputAction textInputAction,VoidCallback onSubmit(String value),VoidCallback onChanged(String value)})
{
  return TextFormField
  (
    controller: controller,
    obscureText: isObsecure,
    readOnly: isReadOnly,
    keyboardType: textInputType,
    textInputAction: textInputAction,
    decoration: InputDecoration
    (
      hintText: placeholder,
      contentPadding: padding,
      labelText: labelText,
      border: inputBorder,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon
    ),
    maxLines: maxLine,
    validator: (value)
    {
      if(validator == null) return null;
      return validator(value);
    },
    onTap: onTap,
    onFieldSubmitted: (value)
    {
      if(onSubmit == null) return;
      onSubmit(value);
    },
    onChanged: (value)
    {
      if(onChanged == null) return;
      onChanged(value);
    },
  );
}
}