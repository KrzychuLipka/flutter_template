import 'package:arcgis_maps/arcgis_maps.dart';

class ArcGisConfig {
  static void setUp() {
    ArcGISEnvironment.apiKey =
        'AAPKd7ba0f57475a4ac38a57b649bc5171feUIkt2m3Per1ZdEn-vGRR2XfQRprl-hVuq45ADvgH0A67E-3oVSQg1KdDtfL_rvwU';
    ArcGISEnvironment.setLicenseUsingKey('runtimelite,1000,rud3084639497,none,6PB3LNBHPFJPA1GJH148');
  }
}
