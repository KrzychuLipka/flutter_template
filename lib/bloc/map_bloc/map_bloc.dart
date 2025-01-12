import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/consts/map_consts.dart';
import 'package:flutter_template/common/utils/logger.dart';
import 'package:flutter_template/data/repository/building/buildings_repository.dart';
import 'package:get_it/get_it.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final _mapViewController = ArcGISMapView.createController();
  final _buildingsRepository = GetIt.instance<BuildingsRepository>();

  ArcGISMapViewController get mapViewController => _mapViewController;

  MapBloc() : super(Initial()) {
    Logger.d('state: $state');
    on<MapEvent>((event, emitter) async {
      Logger.d('event: $event');
      // if (event is ToggleWmsLayer) {
      //   emitter(RefreshWidgetState());
      // }
    });
  }

  void setUpMap() {
    _mapViewController.arcGISMap =
        ArcGISMap.withBasemapStyle(MapConsts.initialMapStyle);
    _mapViewController.setViewpoint(
      Viewpoint.withLatLongScale(
        latitude: MapConsts.initialPointLat,
        longitude: MapConsts.initialPointLng,
        scale: MapConsts.initialScale,
      ),
    );
  }

  void fetchBuildings() async {
    // TODO Loader + Error handling
    try {
      final getClustersResponse = await _buildingsRepository.getClusters();
      final clusterFeatures = getClustersResponse.clusterFeatures ?? [];
      for (var i = 0; i < clusterFeatures.length; i++) {
        final cluster = clusterFeatures[i];
        Logger.d('Cluster ID: ${cluster.cluster?.id}');
      }
    } catch (error) {
      Logger.d('Fetch buildings error: $error');
    }
  }
}
