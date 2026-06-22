import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/image.dart';
import '../../response/api_result.dart';

part 'image_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class ImageApi {
  factory ImageApi(Dio dio, {String baseUrl}) = _ImageApi;

  @GET("/image/{identifier}/identifier")
  Future<HttpResponse<ApiResult<Image>>> retrieve({
    @Path("identifier") required String identifier,
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });
}
