import 'package:intl/intl.dart';

class Helper
{
  static bool validateEmail(String email)
  {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
  
  formatCurrency(int value)
  {
    final nc = new NumberFormat("#,##0", "en_US");
    return value == null?'0':nc.format(value);
  }
}