import 'package:flutter_template/common/utils/geo_locator_utils.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/data/repository/fossils_repository.dart';
import 'package:get_it/get_it.dart';

class DiConfig {
  static void setUpDI() {
    final getIt = GetIt.instance;
    getIt.registerFactory<ToastUtils>(() => ToastUtils());
    getIt.registerFactory<GeoLocatorUtils>(() => GeoLocatorUtils());
    getIt.registerSingleton<FossilsRepository>(FossilsRepository());
  }
}
