import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/data/model/wms_layer.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapController get mapController => _mapController;
  final MapController _mapController = MapController();
  final List<WMSLayer> _wmsLayers = [
    WMSLayer(name: MapConsts.layerNameParcels),
    WMSLayer(name: MapConsts.layerNameParcelNumbers),
    WMSLayer(name: MapConsts.layerNameBuildings),
  ];

  MapBloc() : super(Initial()) {
    on<MapEvent>((event, emitter) async {
      if (event is ToggleWmsLayer) {
        _toggleWmsLayerActiveState(event.wmsLayerName, emitter);
      }
    });
  }

  List<String> get activeWmsLayerNames {
    final list = _wmsLayers
        .where((layer) => layer.isActive)
        .map((layer) => layer.name)
        .toList();
    for (var listItem in _wmsLayers) {
      print("${listItem.name}: ${listItem.isActive}");
    }
    return list;
  }

  bool isActiveWmsLayer(
    String wmsLayerName,
  ) {
    return _wmsLayers
        .firstWhere((layer) => layer.name == wmsLayerName)
        .isActive;
  }

  void _toggleWmsLayerActiveState(
    String wmsLayerName,
    Emitter<MapState> emitter,
  ) {
    for (var wmsLayer in _wmsLayers) {
      if (wmsLayer.name == wmsLayerName) {
        wmsLayer.isActive = !wmsLayer.isActive;
      }
    }
    emitter(RefreshWidgetState());
  }
}
