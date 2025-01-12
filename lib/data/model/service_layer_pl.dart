class ServiceLayerPL {
  final String layerName;
  final int layerIndex;

  const ServiceLayerPL._(
    this.layerName,
    this.layerIndex,
  );

  static const ServiceLayerPL rooms = ServiceLayerPL._(
    'pomieszczenia',
    5,
  );
  static const ServiceLayerPL staircase = ServiceLayerPL._(
    'schody, instalacje wewnętrzne',
    4,
  );
  static const int clustersBuildingsFloorsIndex = 1;
  static const ServiceLayerPL clustersBuildingsFloors = ServiceLayerPL._(
    'klastry_budynki_pietra',
    clustersBuildingsFloorsIndex,
  );
  static const ServiceLayerPL buildingEntrancesPoi = ServiceLayerPL._(
    'Wejścia i windy',
    28,
  );
  static const ServiceLayerPL importantPlacesPoi = ServiceLayerPL._(
    'Ważne miejsca',
    24,
  );
  static const ServiceLayerPL otherPlacesPoi = ServiceLayerPL._(
    'Pozostałe miejsca',
    23,
  );

  static const List<ServiceLayerPL> values = [
    rooms,
    staircase,
    clustersBuildingsFloors,
    buildingEntrancesPoi,
    importantPlacesPoi,
    otherPlacesPoi,
  ];
}
