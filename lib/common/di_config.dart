import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_template/common/utils/gps_utils.dart';
import 'package:flutter_template/common/utils/map_utils.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:flutter_template/data/repository/building/buildings_api.dart';
import 'package:flutter_template/data/repository/building/buildings_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:retrofit/retrofit.dart';

class DiConfig {
  static final _getIt = GetIt.instance;

  static void setUpDI() {
    _setUpUtils();
    _setUpApi();
    _setUpRepositories();
  }

  static void _setUpUtils() {
    _getIt.registerFactory<GpsUtils>(() => GpsUtils());
    _getIt.registerFactory<MapUtils>(() => MapUtils());
    _getIt.registerFactory<ToastUtils>(() => ToastUtils());
  }

  static void _setUpApi() {
    final dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        if (response.requestOptions.method == HttpMethod.GET) {
          response.data = jsonDecode(response.data as String);
        }
        return handler.next(response);
      },
    ));
    // dio.interceptors.add(LogInterceptor(
    //   request: true,
    //   requestHeader: true,
    //   requestBody: true,
    //   responseHeader: true,
    //   responseBody: true,
    //   error: true,
    //   logPrint: (obj) {
    //     if (kDebugMode) {
    //       print(obj);
    //     }
    //   },
    // ));
    _getIt.registerSingleton<Dio>(dio);
    _getIt.registerSingleton<BuildingsApi>(
      BuildingsApi(dio),
    );
  }

  static void _setUpRepositories() {
    _getIt.registerSingleton<BuildingsRepository>(
      BuildingsRepository(
        api: _getIt.get(),
      ),
    );
  }
}
