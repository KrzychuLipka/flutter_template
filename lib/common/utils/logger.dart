import 'package:flutter/foundation.dart';

class Logger {
  static void d(
    String msg,
  ) {
    if (kDebugMode) {
      print(msg);
    }
  }
}
