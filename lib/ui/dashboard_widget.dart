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
          "AAPKd7ba0f57475a4ac38a57b649bc5171feUIkt2m3Per1ZdEn-vGRR2XfQRprl-hVuq45ADvgH0A67E-3oVSQg1KdDtfL_rvwU",
      initialCenter: const LatLng(50.163022, 19.307356),
      zoom: 15,
      mapStyle: MapStyle.twoD,
      basemap: BaseMap.arcgisTopographic,
      onMapCreated: (controller) async {},
    );
  }
}
