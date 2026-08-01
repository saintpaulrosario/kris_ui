import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/sound.dart';
import '../../response/api_result.dart';

part 'sound_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class SoundApi {
  factory SoundApi(Dio dio, {String baseUrl}) = _SoundApi;

  @GET("/sound")
  Future<HttpResponse<ApiResult<List<Sound>>>> retrieve(
    @Query("skus", encoded: true) List<String> skus,
  );

  @GET("/sound/{identifier}")
  Future<HttpResponse<ApiResult<Sound>>> retrieveBySku(
    @Path("identifier") String identifier, {
    @Query("sku", encoded: true) bool? sku,
    @Query("ordinal", encoded: true) bool? ordinal,
  });
}
