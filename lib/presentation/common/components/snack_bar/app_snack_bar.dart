import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSnackBar{
  static void show(BuildContext context, String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 5),
    ));
  }
}