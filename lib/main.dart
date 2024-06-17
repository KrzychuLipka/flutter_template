import 'package:flutter/material.dart';
import 'package:flutter_template/common/di_config.dart';
import 'package:flutter_template/ui/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DiConfig.setUpDI();
  runApp(const AppWidget());
}
