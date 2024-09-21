import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

class GlobalMethods {

  static String formattedDateText(String publishedAt) {
    DateTime parsedDate = DateTime.parse(publishedAt);
    String formattedDate = DateFormat("yyyy-MM-dd hh:mm:ss").format(parsedDate);
    DateTime publishedDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(formattedDate);

    return '${publishedDate.day}/${publishedDate.month}/${publishedDate.year} ON ${publishedDate.hour}:${publishedDate.minute}';
 
  }
  static Future<void> errorDialog({
  required String errormessage, required BuildContext context
})async {
await showDialog(context: context, builder: (context) => AlertDialog(
  title: Row(
    children: [
      Icon(IconlyBold.danger, color: Colors.red,),
      SizedBox(width: 10,),
      Text(errormessage),
    ],
  ),  
  content: Text('An error occured '),
  actions: [
    TextButton(onPressed: (){
     if (Navigator.canPop(context)) {
       Navigator.pop(context);
     }
    }, child: Text('OK'))
  ],
));
}
}