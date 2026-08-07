import 'package:dio/dio.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/translation_text.dart';
import 'package:retrofit/retrofit.dart';
import '../model/translation_content.dart';
import '../model/translation_payload.dart';
import '../response/api_result.dart';
import '../response/page_result.dart';
import 'word_api.dart';

part 'dialect_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class DialectApi
    implements
        WordApi<
          Dialect,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  factory DialectApi(Dio dio, {String baseUrl}) = _DialectApi;

  @override
  @GET("/dialect")
  Future<HttpResponse<ApiResult<PageResult<Dialect>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
  });

  @override
  @GET("/dialect/{identifier}")
  Future<HttpResponse<ApiResult<Dialect>>> fetch(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/dialect/text/{identifier}")
  Future<HttpResponse<ApiResult<TranslationText>>> fetchForText(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/dialect/content/{identifier}")
  Future<HttpResponse<ApiResult<TranslationContent>>> fetchForContent(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/dialect/payload/{identifier}")
  Future<HttpResponse<ApiResult<TranslationPayload>>> fetchForPayload(
    @Path("identifier") String identifier,
  );
}
