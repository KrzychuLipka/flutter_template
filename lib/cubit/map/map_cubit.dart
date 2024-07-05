import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/data/model/base_map_info.dart';
import 'package:flutter_template/data/model/map_position.dart';
import 'package:flutter_template/data/model/search_item.dart';
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

  List<SearchItem> get searchItems => _searchItems;
  List<SearchItem> _searchItems = [];

  LatLng? get markerPosition => _markerPosition;
  LatLng? _markerPosition;

  MapCubit() : super(FossilsDownloadingState()) {
    downloadFossils();
  }

  void downloadFossils() async {
    emit(FossilsDownloadingState());
    try {
      final fossils = await _fossilsRepository.getFossils();
      _searchItems = fossils.map((fossil) {
        return SearchItem(
          id: fossil.id ?? FossilDto.defaultId,
          title: fossil.findDescription,
          subTitle: fossil.geologicalPeriod,
          mapPosition: MapPosition(
            latitude: fossil.discoveryPlace[FossilDto.fieldNameLatitude],
            longitude: fossil.discoveryPlace[FossilDto.fieldNameLongitude],
            name: fossil.discoveryPlace[FossilDto.fieldNameDiscoveryPlaceName],
          ),
        );
      }).toList();
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

  void saveMarkerPosition(
    SearchItem searchItem,
  ) {
    final mapPosition = searchItem.mapPosition;
    final longitude = mapPosition.longitude;
    final latitude = mapPosition.latitude;
    if (latitude == null || longitude == null) return;
    _markerPosition = LatLng(latitude, longitude);
    emit(RefreshState());
  }
}
