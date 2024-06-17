import 'package:latlong2/latlong.dart';

class MapConsts {
  static const String baseMapUrlTemplate =
      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String wmsUrl =
      'https://integracja02.gugik.gov.pl/cgi-bin/KrajowaIntegracjaEwidencjiGruntow?';
  static const String wmsDataFormat = 'image/png';
  static const String wmsVersion = '1.1.1';
  static const String layerNameParcels = 'dzialki';
  static const String layerNameParcelNumbers = 'numery_dzialek';
  static const String layerNameBuildings = 'budynki';
  static const LatLng initialCenter = LatLng(52.203678, 20.884246);
  static const double initialZoom = 15;
}
