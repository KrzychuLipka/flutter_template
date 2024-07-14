import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geo_app/common/di_config.dart';
import 'package:geo_app/common/utils/logger.dart';
import 'package:geo_app/ui/app_widget.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DiConfig.setUpDI();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).catchError((error) {
    Logger.d(error);
    return error;
  }).whenComplete(() {
    runApp(const AppWidget());
  });
}
