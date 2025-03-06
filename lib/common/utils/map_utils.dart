import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapUtils {
  ArcGISMapViewController get mapViewController => _mapViewController;
  final _mapViewController = ArcGISMapView.createController();

  void setUpMap(
    Position position,
  ) {
    FeatureCollectionLayer featureCollectionLayer =
        _createFeatureCollectionLayer(position);
    ArcGISMap arcGISMap = _createArcGISMap();
    arcGISMap.operationalLayers.add(featureCollectionLayer);
    _mapViewController.arcGISMap = arcGISMap;
  }

  ArcGISMap _createArcGISMap() {
    return ArcGISMap.withBasemapStyle(BasemapStyle.arcGISTopographicBase)
      ..initialViewpoint = Viewpoint.fromTargetExtent(Envelope.fromXY(
        xMin: 14.0,
        yMin: 49.0,
        xMax: 24.0,
        yMax: 55.0,
        spatialReference: SpatialReference(wkid: 4326),
      ));
  }

  FeatureCollectionLayer _createFeatureCollectionLayer(
    Position position,
  ) {
    final pointTable = _createPointTable(position);
    final featureCollection = FeatureCollection()
      ..tables.addAll([
        pointTable,
      ]);
    return FeatureCollectionLayer.withFeatureCollection(featureCollection);
  }

  FeatureCollectionTable _createPointTable(
    Position position,
  ) {
    final pointTable = FeatureCollectionTable(
      fields: [
        Field.text(
          name: 'Place',
          alias: 'Place Name',
          length: 50,
        ),
      ],
      geometryType: GeometryType.point,
      spatialReference: SpatialReference(
        wkid: 4326,
      ),
    );
    pointTable.renderer = SimpleRenderer(
      symbol: SimpleMarkerSymbol(
        style: SimpleMarkerSymbolStyle.circle,
        color: Colors.red,
        size: 30,
      ),
    );
    final point = ArcGISPoint(
      x: position.longitude,
      y: position.latitude,
      spatialReference: SpatialReference.wgs84,
    );
    final feature = pointTable.createFeature(
      attributes: {
        'Place': 'Current location',
      },
      geometry: point,
    );
    pointTable.addFeature(feature);
    return pointTable;
  }
}
