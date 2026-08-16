import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';

import 'package:retrofit/retrofit.dart';
import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

part 'word_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class WordApi implements BaseApi<Dialect, Text, Content, Payload> {
  factory WordApi(Dio dio, {String baseUrl}) = _WordApi;

  @override
  @GET("/word")
  Future<HttpResponse<ApiResult<PageResult<Dialect>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
  });

  @override
  @GET("/word/{identifier}")
  Future<HttpResponse<ApiResult<Dialect>>> fetch({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/word/text/{identifier}")
  Future<HttpResponse<ApiResult<Text>>> fetchText({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/word/text")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Query("scripts", encoded: true) List<String>? scripts,
    @Query("identifiers", encoded: true) required List<String> identifiers,
  });

  @override
  @GET("/word/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/word/content")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Query("identifier", encoded: true) required List<String> identifiers,
    @Query("languages", encoded: true) List<String>? languages,
  });

  @override
  @GET("/word/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/word/payload/{identifier}")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Query("identifiers", encoded: true) required List<String> identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
  });
}
