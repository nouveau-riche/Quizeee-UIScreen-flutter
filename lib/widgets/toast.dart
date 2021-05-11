import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool> toast(String message, {bool isError}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError ? Colors.redAccent : Colors.green,
    textColor: Colors.black,
    fontSize: 15.0,
  );
}

Future<bool> cancelToast() {
  return Fluttertoast.cancel();
}
