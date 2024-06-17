import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocaleUtils {
  static const List<Locale> supportedLocales = [
    Locale('en', _countryCodeUS),
    Locale('pl', _countryCodePL)
  ];
  static const _countryCodeUS = 'US';
  static const _countryCodePL = 'PL';

  final Locale locale;

  AppLocaleUtils(
    this.locale,
  );

  static AppLocaleUtils of(
    BuildContext context,
  ) {
    return Localizations.of<AppLocaleUtils>(context, AppLocaleUtils)!;
  }

  static const LocalizationsDelegate<AppLocaleUtils> delegate =
      _AppLocaleUtilsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    final String jsonString =
        await rootBundle.loadString('i18n/${locale.toLanguageTag()}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(
    String key,
  ) {
    return _localizedStrings[key] ?? "";
  }
}

class _AppLocaleUtilsDelegate extends LocalizationsDelegate<AppLocaleUtils> {
  const _AppLocaleUtilsDelegate();

  @override
  bool isSupported(
    Locale locale,
  ) {
    return AppLocaleUtils.supportedLocales.contains(locale);
  }

  @override
  Future<AppLocaleUtils> load(
    Locale locale,
  ) async {
    AppLocaleUtils appLocaleUtils = AppLocaleUtils(locale);
    await appLocaleUtils.load();
    return appLocaleUtils;
  }

  @override
  bool shouldReload(
    _AppLocaleUtilsDelegate delegate,
  ) {
    return delegate != this;
  }
}
