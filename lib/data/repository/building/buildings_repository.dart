import 'package:flutter_template/data/repository/building/buildings_api.dart';
import 'package:flutter_template/data/repository/building/dto/get_clusters_response_dto.dart';

class BuildingsRepository {
  final BuildingsApi api;

  BuildingsRepository({
    required this.api,
  });

  Future<GetClustersResponseDto> getClusters() => api.getClusters();
}
