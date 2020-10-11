import 'package:flutter/material.dart';
import 'package:shoesmart/ui/base/component/CompText.dart';

class CompDialog
{
  
  static warningDialog(BuildContext context,String content)
  {
    showDialog
    (
      context: context,
      builder: (context)
      {
        return AlertDialog
        (
          contentPadding: EdgeInsets.all(0),
          title: Center
          (
            child: CompText.text(label: 'Warning'),
          ),
          content: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>
            [
              SizedBox(height: 8,),
              Padding(
                padding: EdgeInsets.all(16),
                child: CompText.text(label: content),
              ),
              SizedBox(height: 8,),
              Divider(height: 1,color: Colors.grey,),
              SizedBox(height: 8,),
              Center(
                child: InkWell
                (
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CompText.text(label: 'OK')
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(height: 8,),
            ],
          ),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(8)
          ),
          elevation: 4.0,
        );
      }
    );
  }

  
  
  static Future<Null> confirmDialog(BuildContext context,String title,String content,VoidCallback onAccept,{String cancelLabel:'Batal',String acceptLabel:'OK'}) async
  {
    await showDialog
    (
      context: context,
      builder: (context)
      {
        return AlertDialog
        (
          contentPadding: EdgeInsets.all(0),
          title: CompText.text(label: title),
          content: Padding(
            padding: EdgeInsets.all(24),
            child: CompText.text(label: content),
          ),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(8)
          ),
          elevation: 4.0,
          actions: <Widget>
          [
            FlatButton
            (
              child: CompText.text(label: cancelLabel),
              onPressed: ()
              {
                Navigator.of(context).pop();
              },
            ),
            FlatButton
            (
              child: CompText.text(label: acceptLabel),
              onPressed: onAccept,
            ),
          ],
        );
      }
    );
  }

}