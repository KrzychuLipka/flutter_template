import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/data/model/base_map_info.dart';
import 'package:flutter_template/data/model/marker_data.dart';
import 'package:flutter_template/data/repository/dto/fossil_dto.dart';
import 'package:flutter_template/data/repository/fossils_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final FossilsRepository _fossilsRepository =
      GetIt.instance.get<FossilsRepository>();

  List<BaseMapInfo> get baseMapsInfo => _baseMapsInfo;
  final List<BaseMapInfo> _baseMapsInfo = [
    BaseMapInfo(
      urlTemplate: MapConsts.openTopoMapTemplate,
      isActive: true,
    ),
    BaseMapInfo(
      urlTemplate: MapConsts.osmMapTemplate,
    ),
  ];

  List<FossilDto> get fossils => _fossils;
  List<FossilDto> _fossils = [];

  MarkerData? get markerData => _markerData;
  MarkerData? _markerData;

  MapCubit() : super(FossilsDownloadingState()) {
    downloadFossils();
  }

  void downloadFossils() async {
    emit(FossilsDownloadingState());
    try {
      _fossils = await _fossilsRepository.getFossils();
      emit(RefreshState());
    } catch (error) {
      _handleError(
        error: error,
        errorMessageKey: 'map.finds_retrieving_error',
      );
    }
  }

  void _handleError({
    dynamic error,
    required String errorMessageKey,
  }) {
    if (error != null) {
      Logger.d('$error');
    }
    emit(ErrorState(
      errorMessageKey: errorMessageKey,
    ));
  }

  void toggleBaseMap() {
    int prevActiveBaseMapIndex =
        _baseMapsInfo.indexWhere((config) => config.isActive);
    _baseMapsInfo[prevActiveBaseMapIndex].isActive = false;
    int nextActiveBaseMapIndex =
        (prevActiveBaseMapIndex + 1) % _baseMapsInfo.length;
    _baseMapsInfo[nextActiveBaseMapIndex].isActive = true;
    emit(RefreshState());
  }

  void saveMarkerData(
    FossilDto fossilDto,
  ) {
    final discoveryPlace = fossilDto.discoveryPlace;
    final longitude = discoveryPlace[FossilDto.fieldNameLongitude];
    final latitude = discoveryPlace[FossilDto.fieldNameLatitude];
    if (latitude == null || longitude == null) return;
    _markerData = MarkerData(
      position: LatLng(latitude, longitude),
      photoURL: fossilDto.photoURL,
      row1: fossilDto.findDescription,
      row2: fossilDto.fossilType,
      row3: fossilDto.geologicalPeriod,
    );
    emit(RefreshState());
  }

  void clearMarkerData() {
    if (_markerData != null) {
      _markerData = null;
      emit(RefreshState());
    }
  }
}
