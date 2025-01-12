// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_clusters_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetClustersResponseDto _$GetClustersResponseDtoFromJson(
        Map<String, dynamic> json) =>
    GetClustersResponseDto(
      clusterFeatures: (json['features'] as List<dynamic>?)
          ?.map((e) => ClusterFeatureDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetClustersResponseDtoToJson(
        GetClustersResponseDto instance) =>
    <String, dynamic>{
      'features': instance.clusterFeatures,
    };
