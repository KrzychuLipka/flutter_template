import 'package:flutter_template/data/repository/building/dto/cluster_feature_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_clusters_response_dto.g.dart';

@JsonSerializable()
class GetClustersResponseDto {
  @JsonKey(name: 'features')
  final List<ClusterFeatureDto>? clusterFeatures;

  GetClustersResponseDto({
    this.clusterFeatures,
  });

  factory GetClustersResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetClustersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetClustersResponseDtoToJson(this);
}
