import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/utils/gps_utils.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/common/utils/map_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final _mapUtils = GetIt.instance<MapUtils>();
  final _gpsUtils = GetIt.instance<GpsUtils>();

  ArcGISMapViewController get mapViewController => _mapUtils.mapViewController;

  MapBloc() : super(Initial()) {
    Logger.d('state: $state');
    on<MapEvent>((event, emitter) async {
      Logger.d('event: $event');
    });
  }

  void setUpMap() async {
    try {
      Position position = await _gpsUtils.determinePosition();
      _mapUtils.setUpMap(position);
    } catch (error) {
      Logger.d('error: $error');
    }
  }
}
