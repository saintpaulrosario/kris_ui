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
    @Query("page") required int page,
    @Query("size") required int size,
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
  @GET("/script/text/{identifier}")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Header("scripts") Set<String>? scripts,
    @Path("identifier") required List<String> identifiers,
  });

  @override
  @GET("/script/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/script/content/{identifier}")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Header("languages") Set<String>? languages,
    @Path("identifier") required List<String> identifiers,
  });

  @override
  @GET("/script/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/script/payload/{identifier}")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Path("identifier") required List<String> identifiers,
    @Header("dialects") Set<String>? dialects,
  });
}
