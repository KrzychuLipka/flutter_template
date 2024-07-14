import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geo_app/common/app_theme.dart';
import 'package:geo_app/common/utils/app_locale_utils.dart';
import 'package:geo_app/cubit/map/map_cubit.dart';
import 'package:geo_app/ui/map_widget.dart';

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
      home: BlocProvider<MapCubit>(
        create: (_) => MapCubit(),
        child: MapWidget(),
      ),
    );
  }
}
