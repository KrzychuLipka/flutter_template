import 'package:flutter/material.dart';
import 'package:flutter_template/common/dimens.dart';

final appTheme = ThemeData(
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.amber,
    backgroundColor: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.amber,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: Dimens.fontSizeMedium,
    ),
    iconTheme: IconThemeData(
      color: Colors.amber,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
      minimumSize: const Size(double.infinity, Dimens.buttonSize),
    ),
  ),
);
