import 'package:bloc/bloc.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/data/model/base_map_info.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit()
      : super(MapState(baseMapsInfo: [
          BaseMapInfo(
            urlTemplate: MapConsts.openTopoMapTemplate,
            isActive: true,
          ),
          BaseMapInfo(
            urlTemplate: MapConsts.osmMapTemplate,
          ),
        ]));

  void toggleBaseMap() {
    final baseMapsInfo = state.baseMapsInfo;
    int prevActiveBaseMapIndex =
        baseMapsInfo.indexWhere((config) => config.isActive);
    baseMapsInfo[prevActiveBaseMapIndex].isActive = false;
    int nextActiveBaseMapIndex =
        (prevActiveBaseMapIndex + 1) % baseMapsInfo.length;
    baseMapsInfo[nextActiveBaseMapIndex].isActive = true;
    emit(MapState(
      baseMapsInfo: baseMapsInfo,
    ));
  }
}
