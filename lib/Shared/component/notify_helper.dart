import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotifyHelper {
  static void showToast(String message, Color backGroundColor) =>
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: backGroundColor,
          textColor: Colors.white,
          fontSize: 16.0);
}
