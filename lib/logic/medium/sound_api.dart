import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../response/api_result.dart';
part 'sound_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class SoundApi {
  factory SoundApi(Dio dio, {String baseUrl}) = _SoundApi;

  @GET("/sound/{identifier}")
  Future<HttpResponse<ApiResult<dynamic>>> retrieve({
    @Path("identifier") required String identifier,
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });

  @GET("/sound")
  Future<HttpResponse<ApiResult<dynamic>>> retrieveByIdentifiers({
    @Query("identifiers", encoded: true) List<String>? identifiers,
  });
}
