import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(String title) {
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Color(0xFF111111).withOpacity(0.9),
      textColor: Colors.white,
      fontSize: 16.0);
}
