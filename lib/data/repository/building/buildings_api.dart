import 'package:dio/dio.dart';
import 'package:flutter_template/common/api_consts.dart';
import 'package:flutter_template/data/repository/building/dto/get_clusters_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'buildings_api.g.dart';

@RestApi()
abstract class BuildingsApi {
  factory BuildingsApi(
    Dio dio,
  ) = _BuildingsApi;

  @GET("${ApiConstsPL.clustersLayerURL}/query?where=1%3D1&outFields=*&f=pjson")
  Future<GetClustersResponseDto> getClusters();
}
