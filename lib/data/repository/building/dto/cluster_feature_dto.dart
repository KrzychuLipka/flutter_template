import 'package:flutter_template/data/repository/building/dto/cluster_dto.dart';
import 'package:flutter_template/data/repository/building/dto/cluster_geometry_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cluster_feature_dto.g.dart';

@JsonSerializable()
class ClusterFeatureDto {
  @JsonKey(name: 'attributes')
  final ClusterDto? cluster;
  @JsonKey(name: 'geometry')
  final ClusterGeometryDto? clusterGeometry;

  ClusterFeatureDto({
    this.cluster,
    this.clusterGeometry,
  });

  factory ClusterFeatureDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ClusterFeatureDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClusterFeatureDtoToJson(this);
}
