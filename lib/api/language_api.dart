import 'package:dio/dio.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/translation_text.dart';
import 'package:retrofit/retrofit.dart';
import '../model/translation_content.dart';
import '../model/translation_payload.dart';
import '../response/api_result.dart';
import '../response/page_result.dart';
import 'word_api.dart';

part 'language_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class LanguageApi
    implements
        WordApi<
          Language,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  factory LanguageApi(Dio dio, {String baseUrl}) = _LanguageApi;

  @override
  @GET("/language")
  Future<HttpResponse<ApiResult<PageResult<Language>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
  });

  @override
  @GET("/language/{identifier}")
  Future<HttpResponse<ApiResult<Language>>> fetch(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/language/text/{identifier}")
  Future<HttpResponse<ApiResult<TranslationText>>> fetchForText(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/language/content/{identifier}")
  Future<HttpResponse<ApiResult<TranslationContent>>> fetchForContent(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/language/payload/{identifier}")
  Future<HttpResponse<ApiResult<TranslationPayload>>> fetchForPayload(
    @Path("identifier") String identifier,
  );
}
