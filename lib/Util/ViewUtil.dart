import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ViewUtil {
  static Future? showSnackBar(String msg, [int duration = 2]) {
    return Get.showSnackbar(GetBar(
      message: msg,
      duration: Duration(seconds: duration),
    ));
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

}
