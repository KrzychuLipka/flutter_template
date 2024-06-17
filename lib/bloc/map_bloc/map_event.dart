part of 'map_bloc.dart';

abstract class MapEvent {}

class ToggleWmsLayer extends MapEvent {
  String wmsLayerName;

  ToggleWmsLayer(
    this.wmsLayerName,
  );
}
