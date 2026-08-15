import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:kris/response/page_result.dart';
import 'package:retrofit/retrofit.dart';
import '../../../response/api_result.dart';

part 'language_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class LanguageApi
    implements BaseApi<Language, Text, Content, Payload> {
  factory LanguageApi(Dio dio, {String baseUrl}) = _LanguageApi;

  @override
  @GET("/language")
  Future<HttpResponse<ApiResult<PageResult<Language>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
  });

  @override
  @GET("/language/{identifier}")
  Future<HttpResponse<ApiResult<Language>>> fetch({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/language/text/{identifier}")
  Future<HttpResponse<ApiResult<Text>>> fetchText({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/language/text/{identifier}")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Path("identifier") required List<String> identifiers,
    @Header("scripts") Set<String>? scripts,
  });

  @override
  @GET("/language/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/language/content/{identifier}")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Header("languages") Set<String>? languages,
    @Path("identifier") required List<String> identifiers,
  });

  @override
  @GET("/language/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/language/payload/{identifier}")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Path("identifier") required List<String> identifiers,
    @Header("dialects") Set<String>? dialects,
  });
}
