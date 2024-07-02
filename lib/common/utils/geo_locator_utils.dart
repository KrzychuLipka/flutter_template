import 'package:flutter_template/data/model/error.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorUtils {
  Future<String> determineUserPosition() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return Future.error(LocationServicesDisabled());
    }
    LocationPermission locationPermissions = await Geolocator.checkPermission();
    if (locationPermissions == LocationPermission.denied) {
      locationPermissions = await Geolocator.requestPermission();
      if (locationPermissions == LocationPermission.denied) {
        return Future.error(LocationPermissionsDenied());
      }
    }
    if (locationPermissions == LocationPermission.deniedForever) {
      return Future.error(LocationPermissionsDeniedForever());
    }
    final position = await Geolocator.getCurrentPosition();
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placeMarks.isEmpty) return '';
    final placeMark = placeMarks.first;
    final country = placeMark.country;
    final administrativeArea = placeMark.administrativeArea;
    final subAdministrativeArea = placeMark.subAdministrativeArea;
    final postalCode = placeMark.postalCode;
    return '$postalCode\n$subAdministrativeArea\n$administrativeArea\n$country';
  }
}
