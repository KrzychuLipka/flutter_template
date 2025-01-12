// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingDto _$BuildingDtoFromJson(Map<String, dynamic> json) => BuildingDto(
      id: (json['id'] as num?)?.toInt(),
      shortName: json['short_name'] as String?,
      longName: json['long_name'] as String?,
      floors: (json['floors'] as List<dynamic>?)
          ?.map((e) => ClusterFloorDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      rooms: (json['rooms'] as List<dynamic>?)
          ?.map((e) => RoomsDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingDtoToJson(BuildingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'short_name': instance.shortName,
      'long_name': instance.longName,
      'floors': instance.floors,
      'rooms': instance.rooms,
    };
