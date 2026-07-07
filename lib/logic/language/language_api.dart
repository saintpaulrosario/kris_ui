import 'package:dio/dio.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:kris/logic/language/language.dart';
import 'package:retrofit/retrofit.dart';
import '../../response/api_result.dart';

part 'language_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class LanguageApi {
  factory LanguageApi(Dio dio, {String baseUrl}) = _LanguageApi;

  @GET("/language/{identifier}")
  Future<HttpResponse<ApiResult<Language>>> retrieveBySku(
    @Path("identifier") String identifier, {
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });

  @GET("/language")
  Future<HttpResponse<ApiResult<List<Language>>>> retriveAll({
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });
}
