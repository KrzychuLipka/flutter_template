import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geo_app/common/consts/map_consts.dart';
import 'package:geo_app/data/model/base_map_info.dart';
import 'package:geo_app/data/model/error.dart';
import 'package:geo_app/data/model/marker_data.dart';
import 'package:geo_app/data/repository/dto/fossil_dto.dart';
import 'package:geo_app/data/repository/fossils_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final FossilsRepository _fossilsRepository =
      GetIt.instance.get<FossilsRepository>();
  final List<BaseMapInfo> _baseMapsInfo = [
    BaseMapInfo(
      urlTemplate: MapConsts.openTopoMapTemplate,
      isActive: true,
    ),
    BaseMapInfo(
      urlTemplate: MapConsts.osmMapTemplate,
    ),
  ];
  final _fossilsStreamController =
      StreamController<List<FossilDto>>.broadcast();
  final _markerDataStreamController = StreamController<MarkerData?>.broadcast();
  final _mapUrlTemplateStreamController = StreamController<String>.broadcast();

  StreamSink<String> get _mapUrlTemplateSink =>
      _mapUrlTemplateStreamController.sink;

  StreamSink<MarkerData?> get _markerDataSink =>
      _markerDataStreamController.sink;

  StreamSink<List<FossilDto>> get _fossilsSink => _fossilsStreamController.sink;

  Stream<String> get mapUrlTemplateStream =>
      _mapUrlTemplateStreamController.stream;

  Stream<MarkerData?> get markerDataStream =>
      _markerDataStreamController.stream;

  Stream<List<FossilDto>> get fossilsStream => _fossilsStreamController.stream;

  MarkerData? _markerData;

  MapCubit() : super(MapInitialState()) {
    downloadFossils();
  }

  void downloadFossils() async {
    try {
      final fossils = await _fossilsRepository.getFossils();
      _fossilsSink.add(fossils);
    } catch (error) {
      _fossilsSink.addError(GeneralError(
        msgKey: 'map.finds_retrieving_error',
        technicalMsg: '$error',
      ));
    }
  }

  void toggleBaseMap() {
    int prevActiveBaseMapIndex =
        _baseMapsInfo.indexWhere((config) => config.isActive);
    _baseMapsInfo[prevActiveBaseMapIndex].isActive = false;
    int nextActiveBaseMapIndex =
        (prevActiveBaseMapIndex + 1) % _baseMapsInfo.length;
    _baseMapsInfo[nextActiveBaseMapIndex].isActive = true;
    final activeMapUrlTemplate = _baseMapsInfo
        .firstWhere((baseMapInfo) => baseMapInfo.isActive)
        .urlTemplate;
    _mapUrlTemplateSink.add(activeMapUrlTemplate);
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
    _markerDataSink.add(_markerData);
  }

  void clearMarkerData() {
    if (_markerData != null) {
      _markerData = null;
      _markerDataSink.add(null);
    }
  }

  LatLng getMapInitialPoint() =>
      _markerData?.position ?? MapConsts.initialCenter;
}
