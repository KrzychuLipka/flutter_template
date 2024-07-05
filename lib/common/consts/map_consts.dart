import 'package:latlong2/latlong.dart';

class MapConsts {
  static const String openTopoMapTemplate =
      'https://tile.opentopomap.org/{z}/{x}/{y}.png';
  static const osmMapTemplate =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const LatLng initialCenter = LatLng(49.218405, 20.0249624);
  static const double initialZoom = 15;
  static const double markerSize = 200;
}
