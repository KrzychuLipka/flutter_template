import 'package:arcgis_map_sdk/arcgis_map_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/utils/toast_utils.dart';
import 'package:get_it/get_it.dart';

class DashboardWidget extends StatelessWidget {
  final ToastUtils _toastUtils = GetIt.instance.get<ToastUtils>();

  DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _map(context),
    );
  }

  Widget _map(
    BuildContext context,
  ) {
    return ArcgisMap(
      apiKey:
          "AAPK1eb4be74567341b981d400f7f93c4201WSEP1mvip9J-4VdMiNlM1Rmo5ml5eV59N94vMBAnjHj4AwaZZuT2t3diaViORi_3",
      initialCenter: const LatLng(51.16, 10.45),
      zoom: 8,
      mapStyle: MapStyle.twoD,
      basemap: BaseMap.arcgisChartedTerritory,
      // onMapCreated: (controller) async {
      //   const pinLayerId = 'pins';
      //   await controller.addGraphic(
      //     layerId: pinLayerId,
      //     graphic: PointGraphic(
      //       latitude: 51.091062,
      //       longitude: 6.880812,
      //       attributes: Attributes({
      //         'id': 'phntm',
      //         'name': 'PHNTM GmbH',
      //         'family': 'Office',
      //       }),
      //       symbol: const PictureMarkerSymbol(
      //         webUri:
      //             "https://github.com/fluttercommunity/arcgis_map/assets/1096485/94178dba-5bb8-4f1e-a160-31bfe4c93d17",
      //         mobileUri:
      //             "https://github.com/fluttercommunity/arcgis_map/assets/1096485/94178dba-5bb8-4f1e-a160-31bfe4c93d17",
      //         width: 314 / 2,
      //         height: 120 / 2,
      //       ),
      //     ),
      //   );
      //
      //   await controller.addGraphic(
      //     layerId: pinLayerId,
      //     graphic: PointGraphic(
      //       latitude: 48.1234963,
      //       longitude: 11.5910182,
      //       attributes: Attributes({
      //         'id': 'tapped',
      //         'name': 'Tapped UG',
      //         'family': 'Office',
      //       }),
      //       symbol: const PictureMarkerSymbol(
      //         webUri:
      //             "https://github.com/fluttercommunity/arcgis_map/assets/1096485/c84c524c-78b7-46e5-9bf1-a3a91853b2cf",
      //         mobileUri:
      //             "https://github.com/fluttercommunity/arcgis_map/assets/1096485/c84c524c-78b7-46e5-9bf1-a3a91853b2cf",
      //         width: 312 / 2,
      //         height: 111 / 2,
      //       ),
      //     ),
      //   );
      // },
    );
  }
}
