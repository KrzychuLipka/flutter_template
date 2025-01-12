import 'package:flutter_template/data/repository/building/dto/cluster_floor_dto.dart';
import 'package:flutter_template/data/repository/building/dto/rooms_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building_dto.g.dart';

@JsonSerializable()
class BuildingDto {
  final int? id;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'long_name')
  final String? longName;
  final List<ClusterFloorDto>? floors;
  List<RoomsDto>? rooms;

  BuildingDto({
    this.id,
    this.shortName,
    this.longName,
    this.floors,
    this.rooms,
  });

  factory BuildingDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BuildingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingDtoToJson(this);
}
