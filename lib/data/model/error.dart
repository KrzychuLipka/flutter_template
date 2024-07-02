sealed class GeneralError {
  final String _msgKey;
  final String _technicalMsg;

  GeneralError({
    required String msgKey,
    required String technicalMsg,
  })  : _msgKey = msgKey,
        _technicalMsg = technicalMsg;

  String get msgKey => _msgKey;

  String get technicalMsg => _technicalMsg;
}

class LocationServicesDisabled extends GeneralError {
  LocationServicesDisabled()
      : super(
          msgKey: 'geo_locator.location_services_disabled',
          technicalMsg: 'Location services disabled',
        );
}

class LocationPermissionsDenied extends GeneralError {
  LocationPermissionsDenied()
      : super(
          msgKey: 'geo_locator.locations_permissions_denied',
          technicalMsg: 'Location permissions denied',
        );
}

class LocationPermissionsDeniedForever extends GeneralError {
  LocationPermissionsDeniedForever()
      : super(
          msgKey: 'geo_locator.locations_permissions_denied_forever',
          technicalMsg: 'Location permissions denied forever',
        );
}
