// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster_floor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClusterFloorDto _$ClusterFloorDtoFromJson(Map<String, dynamic> json) =>
    ClusterFloorDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      shortName: json['short_name'] as String?,
      longName: json['long_name'] as String?,
      vOrder: (json['v_order'] as num?)?.toInt(),
      main: (json['main'] as num?)?.toInt(),
      fCluster: (json['f_cluster'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bfCluster: (json['bf_cluster'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ClusterFloorDtoToJson(ClusterFloorDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_name': instance.shortName,
      'long_name': instance.longName,
      'v_order': instance.vOrder,
      'main': instance.main,
      'f_cluster': instance.fCluster,
      'bf_cluster': instance.bfCluster,
    };
