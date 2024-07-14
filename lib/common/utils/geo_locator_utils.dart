import 'package:geo_app/common/utils/logger.dart';
import 'package:geo_app/data/model/error.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorUtils {
  Future<Position> determineUserPosition() async {
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
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getFormattedAddress({
    required Position position,
  }) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placeMarks.isEmpty) return '';
      final placeMark = placeMarks.first;
      return '${placeMark.postalCode}\n${placeMark.subAdministrativeArea}\n${placeMark.administrativeArea}\n${placeMark.country}';
    } catch (error) {
      Logger.d('$error');
      return '${position.latitude}; ${position.longitude}';
    }
  }
}
