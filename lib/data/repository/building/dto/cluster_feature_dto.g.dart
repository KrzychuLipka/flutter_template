// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster_feature_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClusterFeatureDto _$ClusterFeatureDtoFromJson(Map<String, dynamic> json) =>
    ClusterFeatureDto(
      cluster: json['attributes'] == null
          ? null
          : ClusterDto.fromJson(json['attributes'] as Map<String, dynamic>),
      clusterGeometry: json['geometry'] == null
          ? null
          : ClusterGeometryDto.fromJson(
              json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClusterFeatureDtoToJson(ClusterFeatureDto instance) =>
    <String, dynamic>{
      'attributes': instance.cluster,
      'geometry': instance.clusterGeometry,
    };
