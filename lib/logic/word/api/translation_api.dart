import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:kris/response/page_result.dart';
import 'package:retrofit/retrofit.dart';
import '../../../model/translation.dart';
import '../../../response/api_result.dart';

part 'translation_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class TranslationApi
    implements BaseApi<Translation, Text, Content, Payload> {
  factory TranslationApi(Dio dio, {String baseUrl}) = _TranslationApi;

  @override
  @GET("/translation")
  Future<HttpResponse<ApiResult<PageResult<Translation>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
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
  @GET("/translation/text/{identifiers}")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Header("scripts") List<String>? scripts,
    @Path("identifiers") required List<String> identifiers,
  });

  @override
  @GET("/translation/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/translation/content/{identifiers}")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Path("identifiers") required List<String> identifiers,
    @Header("languages") List<String>? languages,
  });

  @override
  @GET("/translation/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/translation/payload/{identifiers}")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Path("identifiers") required List<String> identifiers,
    @Header("dialects") List<String>? dialects,
  });
}
