// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_cluster_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingClusterDto _$BuildingClusterDtoFromJson(Map<String, dynamic> json) =>
    BuildingClusterDto(
      clusterShortName: json['cluster_short_name'] as String?,
      clusterLongName: json['cluster_long_name'] as String?,
      buildings: (json['buildings'] as List<dynamic>?)
          ?.map((e) => BuildingDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingClusterDtoToJson(BuildingClusterDto instance) =>
    <String, dynamic>{
      'cluster_short_name': instance.clusterShortName,
      'cluster_long_name': instance.clusterLongName,
      'buildings': instance.buildings,
    };
