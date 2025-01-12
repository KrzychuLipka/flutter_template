// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster_geometry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClusterGeometryDto _$ClusterGeometryDtoFromJson(Map<String, dynamic> json) =>
    ClusterGeometryDto(
      rings: (json['rings'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => (e as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList())
              .toList())
          .toList(),
    );

Map<String, dynamic> _$ClusterGeometryDtoToJson(ClusterGeometryDto instance) =>
    <String, dynamic>{
      'rings': instance.rings,
    };
