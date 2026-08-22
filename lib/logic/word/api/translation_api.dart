import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/response/page_result.dart';
import 'package:retrofit/retrofit.dart';
import '../../../model/translation.dart';
import '../../../response/api_result.dart';

part 'translation_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class TranslationApi
    implements BaseApi<Translation, Text, Content, Payload, Trait> {
  factory TranslationApi(Dio dio, {String baseUrl}) = _TranslationApi;

  @override
  @GET("/translation")
  Future<HttpResponse<ApiResult<PageResult<Translation>>>> fetchAll({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("scripts") List<String>? scripts,
    @Query("identifiers") List<String>? identifiers,
  });

  @override
  @GET("/translation/{identifier}")
  Future<HttpResponse<ApiResult<Translation>>> fetch({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/translation/text/{identifier}")
  Future<HttpResponse<ApiResult<Text>>> fetchText({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/translation/text")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Query("scripts") List<String>? scripts,
    @Query("identifiers") List<String>? identifiers,
  });

  @override
  @GET("/translation/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/translation/content")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Query("identifiers") List<String>? identifiers,
    @Query("languages") List<String>? languages,
    @Query("scripts") List<String>? scripts,
  });

  @override
  @GET("/translation/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/translation/payload")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Query("identifier", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
    @Query("scripts", encoded: true) List<String>? scripts,
    @Query("languages", encoded: true) List<String>? languages,
  });

  @override
  @GET("/translation/trait")
  Future<HttpResponse<ApiResult<List<Trait>>>> fetchTraits({
    @Query("identifiers", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
  });

  @override
  @GET("/translation/trait/{identifier}")
  Future<HttpResponse<ApiResult<Trait>>> fetchTrait({
    @Path("identifier") required String identifier,
  });
}
