import 'package:flutter/material.dart';
import 'package:flutter_template/common/arc_gis_config.dart';
import 'package:flutter_template/common/di_config.dart';
import 'package:flutter_template/ui/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DiConfig.setUpDI();
  ArcGisConfig.setUp();
  runApp(const AppWidget());
}
