import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';

import 'package:retrofit/retrofit.dart';
import '../../../model/script.dart';
import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

part 'script_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class ScriptApi implements BaseApi<Script, Text, Content, Payload> {
  factory ScriptApi(Dio dio, {String baseUrl}) = _ScriptApi;

  @override
  @GET("/script")
  Future<HttpResponse<ApiResult<PageResult<Script>>>> fetchAll({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("scripts") List<String>? scripts,
  });

  @override
  @GET("/script/{identifier}")
  Future<HttpResponse<ApiResult<Script>>> fetch({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/script/text/{identifier}")
  Future<HttpResponse<ApiResult<Text>>> fetchText({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/script/text")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Query("scripts") List<String>? scripts,
    @Query("identifier") List<String>? identifiers,
  });

  @override
  @GET("/script/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/script/content")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Query("languages") List<String>? languages,
    @Query("scripts") List<String>? scripts,
    @Query("identifiers") List<String>? identifiers,
  });

  @override
  @GET("/script/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/script/payload")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Query("identifier", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
    @Query("scripts", encoded: true) List<String>? scripts,
    @Query("languages", encoded: true) List<String>? languages,
  });
}
