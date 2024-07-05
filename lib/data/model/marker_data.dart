import 'package:latlong2/latlong.dart';

class MarkerData {
  final LatLng position;
  final String photoURL;
  final String row1;
  final String row2;
  final String row3;

  MarkerData({
    required this.position,
    required this.photoURL,
    required this.row1,
    required this.row2,
    required this.row3,
  });
}
