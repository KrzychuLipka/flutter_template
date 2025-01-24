import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter/material.dart';

class MapUtils {
  ArcGISMapViewController get mapViewController => _mapViewController;
  final _mapViewController = ArcGISMapView.createController();

  void setUpMap() {
    FeatureCollectionLayer featureCollectionLayer =
        _createFeatureCollectionLayer();
    ArcGISMap arcGISMap = _createArcGISMap();
    arcGISMap.operationalLayers.add(featureCollectionLayer);
    _mapViewController.arcGISMap = arcGISMap;
  }

  ArcGISMap _createArcGISMap() =>
      ArcGISMap.withBasemapStyle(BasemapStyle.arcGISOceans)
        ..initialViewpoint = Viewpoint.fromTargetExtent(
          Envelope.fromXY(
            xMin: -8917856.590171767,
            yMin: 903277.583136797,
            xMax: -8800611.655131537,
            yMax: 1100327.8941287803,
            spatialReference: SpatialReference(wkid: 102100),
          ),
        );

  FeatureCollectionLayer _createFeatureCollectionLayer() {
    final polygonTable = _createPolygonTable();
    final polylineTable = _createPolylineTable();
    final pointTable = _createPointTable();
    final featureCollection = FeatureCollection()
      ..tables.addAll([
        pointTable,
        polylineTable,
        polygonTable,
      ]);
    return FeatureCollectionLayer.withFeatureCollection(featureCollection);
  }

  FeatureCollectionTable _createPointTable() {
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
        style: SimpleMarkerSymbolStyle.triangle,
        color: Colors.red,
        size: 10,
      ),
    );
    final point = ArcGISPoint(
      x: -79.497238,
      y: 8.849289,
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

  FeatureCollectionTable _createPolylineTable() {
    final polylineTable = FeatureCollectionTable(
      fields: [
        Field.text(
          name: 'Boundary',
          alias: 'Boundary Name',
          length: 50,
        ),
      ],
      geometryType: GeometryType.polyline,
      spatialReference: SpatialReference(wkid: 4326),
    );
    polylineTable.renderer = SimpleRenderer(
      symbol: SimpleLineSymbol(
        style: SimpleLineSymbolStyle.dash,
        color: Colors.green,
        width: 3,
      ),
    );
    final polylineBuilder =
        PolylineBuilder(spatialReference: SpatialReference(wkid: 4326));
    polylineBuilder.addPoint(
      ArcGISPoint(
        x: -79.497238,
        y: 8.849289,
        spatialReference: SpatialReference.wgs84,
      ),
    );
    polylineBuilder.addPoint(
      ArcGISPoint(
        x: -80.035568,
        y: 9.432302,
        spatialReference: SpatialReference.wgs84,
      ),
    );
    final polyline = polylineBuilder.toGeometry();
    final feature = polylineTable.createFeature(
      attributes: {
        'Boundary': 'AManAPlanACanalPanama',
      },
      geometry: polyline,
    );
    polylineTable.addFeature(feature);
    return polylineTable;
  }

  FeatureCollectionTable _createPolygonTable() {
    final polygonTable = FeatureCollectionTable(
      fields: [
        Field.text(
          name: 'Area',
          alias: 'Area Name',
          length: 50,
        ),
      ],
      geometryType: GeometryType.polygon,
      spatialReference: SpatialReference(wkid: 4326),
    );
    polygonTable.renderer = SimpleRenderer(
      symbol: SimpleFillSymbol(
        style: SimpleFillSymbolStyle.diagonalCross,
        color: Colors.cyan,
        outline: SimpleLineSymbol(
          style: SimpleLineSymbolStyle.solid,
          color: Colors.blue,
          width: 2,
        ),
      ),
    );
    final polygonBuilder =
        PolygonBuilder(spatialReference: SpatialReference(wkid: 4326));
    polygonBuilder.addPoint(
      ArcGISPoint(
        x: -79.497238,
        y: 8.849289,
        spatialReference: SpatialReference.wgs84,
      ),
    );
    polygonBuilder.addPoint(
      ArcGISPoint(
        x: -79.337936,
        y: 8.638903,
        spatialReference: SpatialReference.wgs84,
      ),
    );
    polygonBuilder.addPoint(
      ArcGISPoint(
        x: -79.11409,
        y: 8.895422,
        spatialReference: SpatialReference.wgs84,
      ),
    );
    final polygon = polygonBuilder.toGeometry();
    final feature = polygonTable.createFeature(
      attributes: {
        'Area': 'Restricted area',
      },
      geometry: polygon,
    );
    polygonTable.addFeature(feature);
    return polygonTable;
  }
}
