import 'package:dio/dio.dart';
import 'package:kris/model/medium.dart';
import 'package:retrofit/retrofit.dart';

import '../../response/api_result.dart';

part 'medium_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class MediumApi {
  factory MediumApi(Dio dio, {String baseUrl}) = _MediumApi;

  @GET("/image/{identifier}")
  Future<HttpResponse<ApiResult<Medium>>> fetch({
    @Path("identifier") required String identifier,
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });

  @GET("/image")
  Future<HttpResponse<ApiResult<List<Medium>>>> fetchAll({
    @Query("identifiers", encoded: true) List<String>? identifiers,
  });
}
