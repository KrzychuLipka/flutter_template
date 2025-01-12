import 'package:flutter_template/data/repository/building/dto/building_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building_cluster_dto.g.dart';

@JsonSerializable()
class BuildingClusterDto {
  @JsonKey(name: 'cluster_short_name')
  final String? clusterShortName;
  @JsonKey(name: 'cluster_long_name')
  final String? clusterLongName;
  final List<BuildingDto>? buildings;

  BuildingClusterDto({
    this.clusterShortName,
    this.clusterLongName,
    this.buildings,
  });

  factory BuildingClusterDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$BuildingClusterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingClusterDtoToJson(this);
}
