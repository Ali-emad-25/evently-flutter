import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static Future<bool?> showToast({
    required String text,
    required Color backgroundColor,
    ToastGravity position = ToastGravity.CENTER,
    double fontSize = 16,
  }) {
    return Fluttertoast.showToast(
      msg: text.tr(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: position,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: AppColors.whiteColor,
      fontSize: fontSize,
    );
  }
}
