import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geo_app/common/app_theme.dart';
import 'package:geo_app/common/utils/app_locale_utils.dart';
import 'package:geo_app/ui/splash_widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    List<LocalizationsDelegate> delegates = [
      AppLocaleUtils.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
    delegates.addAll(GlobalMaterialLocalizations.delegates);
    return MaterialApp(
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: delegates,
      theme: appTheme,
      home: const SplashWidget(),
    );
  }
}
