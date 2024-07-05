class FossilDto {
  static const String fieldNameId = 'id';
  static const String fieldNamePhotoURL = 'photoURL';
  static const String fieldNameFossilType = 'fossilType';
  static const String fieldNameGeologicalPeriod = 'geologicalPeriod';
  static const String fieldNameFindDescription = 'findDescription';
  static const String fieldNameDiscoveryPlace = 'discoveryPlace';
  static const String fieldNameDiscoveryDate = 'discoveryDate';
  static const String fieldNameLatitude = 'latitude';
  static const String fieldNameLongitude = 'longitude';

  String? id;
  final String photoURL;
  final String fossilType;
  final String geologicalPeriod;
  final String findDescription;
  final Map<String, dynamic> discoveryPlace;
  final String discoveryDate;

  FossilDto({
    this.id,
    required this.photoURL,
    required this.fossilType,
    required this.geologicalPeriod,
    required this.findDescription,
    required this.discoveryPlace,
    required this.discoveryDate,
  });

  Map<String, dynamic> toJson() {
    return {
      fieldNamePhotoURL: photoURL,
      fieldNameFossilType: fossilType,
      fieldNameGeologicalPeriod: geologicalPeriod,
      fieldNameFindDescription: findDescription,
      fieldNameDiscoveryPlace: discoveryPlace,
      fieldNameDiscoveryDate: discoveryDate,
    };
  }

  FossilDto.fromJson(
    Map<String, dynamic> json,
  ) : this(
          id: json[fieldNameId],
          photoURL: json[fieldNamePhotoURL],
          fossilType: json[fieldNameFossilType],
          geologicalPeriod: json[fieldNameGeologicalPeriod],
          findDescription: json[fieldNameFindDescription],
          discoveryPlace: json[fieldNameDiscoveryPlace],
          discoveryDate: json[fieldNameDiscoveryDate],
        );
}
