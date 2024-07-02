class FossilDto {
  final String photoId;
  final String fossilType;
  final String geologicalPeriod;
  final String findDescription;
  final String discoveryPlace;
  final String discoveryDate;

  FossilDto({
    required this.photoId,
    required this.fossilType,
    required this.geologicalPeriod,
    required this.findDescription,
    required this.discoveryPlace,
    required this.discoveryDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'photoId': photoId,
      'fossilType': fossilType,
      'geologicalPeriod': geologicalPeriod,
      'findDescription': findDescription,
      'discoveryPlace': discoveryPlace,
      'discoveryDate': discoveryDate,
    };
  }
}
