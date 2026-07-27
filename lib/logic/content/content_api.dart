import 'package:dio/dio.dart';
import 'package:kris/logic/content/content.dart';
import 'package:retrofit/retrofit.dart';
import '../../response/api_result.dart';

part 'content_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class ContentApi {
  factory ContentApi(Dio dio, {String baseUrl}) = _ContentApi;

  @GET("/content")
  Future<HttpResponse<ApiResult<List<Content>>>> retrieveAll();

  @GET("/content/text/{identifier}")
  Future<HttpResponse<ApiResult<List<Content>>>> retrieveTextBySku(
    @Path("identifier") String identifier, {
    @Query("sku") bool? sku,
    @Query("ordinal") bool? ordinal,
  });

  @GET("/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> retrieveByIdentifier(
    @Path("identifier") String identifier,
  );
}
