import 'package:dio/dio.dart';
import 'package:kris/response/page_result.dart';
import 'package:retrofit/retrofit.dart';
import '../model/translation.dart';
import '../model/translation_content.dart';
import '../model/translation_payload.dart';
import '../model/translation_text.dart';
import '../response/api_result.dart';
import 'word_api.dart';

part 'translation_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class TranslationApi
    implements
        WordApi<
          Translation,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  factory TranslationApi(Dio dio, {String baseUrl}) = _TranslationApi;

  @override
  @GET("/translation")
  Future<HttpResponse<ApiResult<PageResult<Translation>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
  });

  @override
  @GET("/translation/{identifier}")
  Future<HttpResponse<ApiResult<Translation>>> fetch(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/translation/text/{identifier}")
  Future<HttpResponse<ApiResult<TranslationText>>> fetchForText(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/translation/content/{identifier}")
  Future<HttpResponse<ApiResult<TranslationContent>>> fetchForContent(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/translation/payload/{identifier}")
  Future<HttpResponse<ApiResult<TranslationPayload>>> fetchForPayload(
    @Path("identifier") String identifier,
  );
}
