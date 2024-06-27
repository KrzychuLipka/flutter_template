import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/common/app_theme.dart';
import 'package:flutter_template/common/utils/app_locale_utils.dart';
import 'package:flutter_template/ui/dashboard_widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [
        AppLocaleUtils.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: appTheme,
      home: DashboardWidget(),
    );
  }
}
