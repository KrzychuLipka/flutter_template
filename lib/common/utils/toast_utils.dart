import 'package:flutter/material.dart';
import 'package:flutter_template/common/dimens.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  void showToast(
    String msgKey,
    BuildContext context, {
    Toast? toastLength = Toast.LENGTH_LONG,
    ToastGravity? gravity = ToastGravity.CENTER,
    Color? backgroundColor = Colors.black,
    Color? textColor = Colors.white,
    double? fontSize = Dimens.fontSizeStandard,
  }) {
    Fluttertoast.showToast(
      msg: AppLocaleUtils.of(context).translate(msgKey),
      toastLength: toastLength,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  void debugToast(
    String msg, {
        Toast? toastLength = Toast.LENGTH_SHORT,
        ToastGravity? gravity = ToastGravity.CENTER,
        Color? backgroundColor = Colors.black,
        Color? textColor = Colors.white,
        double? fontSize = Dimens.fontSizeStandard,
      }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
