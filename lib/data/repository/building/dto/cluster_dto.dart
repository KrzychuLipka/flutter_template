import 'package:json_annotation/json_annotation.dart';

part 'cluster_dto.g.dart';

@JsonSerializable()
class ClusterDto {
  final int? id;
  @JsonKey(name: 'short_name')
  final String? shortName;
  @JsonKey(name: 'long_name')
  final String? longName;
  @JsonKey(name: 'cluster_json')
  final String? clusterJson;

  ClusterDto({
    this.id,
    this.shortName,
    this.longName,
    this.clusterJson,
  });

  factory ClusterDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ClusterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ClusterDtoToJson(this);
}
