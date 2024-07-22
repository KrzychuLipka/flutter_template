import 'package:flutter/material.dart';
import 'package:geo_app/common/dimens.dart';

final appTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: Colors.amber,
    brightness: Brightness.light,
    onPrimary: Colors.white,

    secondary: Colors.amber,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(Dimens.buttonMinHeight),
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        color: Colors.black,
      ),
    ),
  ),
);
