import 'package:json_annotation/json_annotation.dart';

part 'cluster_geometry_dto.g.dart';

@JsonSerializable()
class ClusterGeometryDto {
  final List<List<List<double>>> rings;

  ClusterGeometryDto({
    required this.rings,
  });

  factory ClusterGeometryDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ClusterGeometryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClusterGeometryDtoToJson(this);
}
