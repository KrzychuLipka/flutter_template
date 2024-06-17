import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:get_it/get_it.dart';

class DiConfig {
  static void setUpDI() {
    final getIt = GetIt.instance;
    getIt.registerFactory<ToastUtils>(() => ToastUtils());
  }
}
