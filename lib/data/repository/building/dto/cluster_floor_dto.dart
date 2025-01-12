import 'package:json_annotation/json_annotation.dart';

part 'cluster_floor_dto.g.dart';

@JsonSerializable()
class ClusterFloorDto {
  final int? id;
  final String name;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'long_name')
  final String? longName;
  @JsonKey(name: 'v_order')
  final int? vOrder;
  final int? main;
  @JsonKey(name: 'f_cluster')
  final List<String>? fCluster;
  @JsonKey(name: 'bf_cluster')
  final List<String>? bfCluster;

  ClusterFloorDto({
    this.id,
    required this.name,
    this.shortName,
    this.longName,
    this.vOrder,
    this.main,
    this.fCluster,
    this.bfCluster,
  });

  factory ClusterFloorDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ClusterFloorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClusterFloorDtoToJson(this);
}
