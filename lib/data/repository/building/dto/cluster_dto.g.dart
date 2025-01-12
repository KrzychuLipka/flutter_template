// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClusterDto _$ClusterDtoFromJson(Map<String, dynamic> json) => ClusterDto(
      id: (json['id'] as num?)?.toInt(),
      shortName: json['short_name'] as String?,
      longName: json['long_name'] as String?,
      clusterJson: json['cluster_json'] as String?,
    );

Map<String, dynamic> _$ClusterDtoToJson(ClusterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'short_name': instance.shortName,
      'long_name': instance.longName,
      'cluster_json': instance.clusterJson,
    };
