
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// @name ETTToast
/// @description 显示toast
/// @author lca
/// @date 2019-11-28
///
class ETTToast {

  static toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}








