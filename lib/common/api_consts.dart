import 'package:flutter_template/data/model/service_layer_pl.dart';

class ApiConstsPL {
  static const String _sionTopographyBaseUrl =
      'https://arcgis.cenagis.edu.pl/server/rest/services/SION2_Topo_MV';
  static const String buildingsApiUrl =
      '$_sionTopographyBaseUrl/sion2_topo_indoor_all/MapServer/';
  static const String _clustersUrl =
      '$_sionTopographyBaseUrl/sion2_wfs_klastry_budynki';
  static const String _mapServerName = 'MapServer';
  static const String poiApiUrl =
      '$_sionTopographyBaseUrl/sion_topo_POI_style/$_mapServerName/';

  static const String clustersLayerURL =
      '$_clustersUrl/$_mapServerName/${ServiceLayerPL.clustersBuildingsFloorsIndex}';
}
