class FossilDto {
  static const String fieldNamePhotoURL = 'photoURL';
  static const String fieldNameFossilType = 'fossilType';
  static const String fieldNameGeologicalPeriod = 'geologicalPeriod';
  static const String fieldNameFindDescription = 'findDescription';
  static const String fieldNameDiscoveryPlace = 'discoveryPlace';
  static const String fieldNameDiscoveryDate = 'discoveryDate';
  static const String fieldNameLatitude = 'latitude';
  static const String fieldNameLongitude = 'longitude';

  final String photoURL;
  final String fossilType;
  final String geologicalPeriod;
  final String findDescription;
  final Map<String, double> discoveryPlace;
  final String discoveryDate;

  FossilDto({
    required this.photoURL,
    required this.fossilType,
    required this.geologicalPeriod,
    required this.findDescription,
    required this.discoveryPlace,
    required this.discoveryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      fieldNamePhotoURL: photoURL,
      fieldNameFossilType: fossilType,
      fieldNameGeologicalPeriod: geologicalPeriod,
      fieldNameFindDescription: findDescription,
      fieldNameDiscoveryPlace: discoveryPlace,
      fieldNameDiscoveryDate: discoveryDate,
    };
  }
}
