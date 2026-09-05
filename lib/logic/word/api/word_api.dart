import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/model/word.dart';

import 'package:retrofit/retrofit.dart';
import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

part 'word_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class WordApi implements BaseApi<Word, Text, Content, Payload, Trait> {
  factory WordApi(Dio dio, {String baseUrl}) = _WordApi;

  @override
  @GET("/word")
  Future<HttpResponse<ApiResult<PageResult<Word>>>> fetchAll({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("scripts") List<String>? scripts,
    @Query("identifiers") List<String>? identifiers,
  });

  @override
  @GET("/word/{identifier}")
  Future<HttpResponse<ApiResult<Word>>> fetch({
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
    @Query("identifiers", encoded: true) List<String>? identifiers,
  });

  @override
  @GET("/word/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/word/content")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Query("identifiers", encoded: true) List<String>? identifiers,
    @Query("scripts", encoded: true) List<String>? scripts,
    @Query("languages", encoded: true) List<String>? languages,
  });

  @override
  @GET("/word/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/word/payload")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Query("identifiers", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
    @Query("scripts", encoded: true) List<String>? scripts,
    @Query("languages", encoded: true) List<String>? languages,
  });

  @override
  @GET("/word/trait")
  Future<HttpResponse<ApiResult<List<Trait>>>> fetchTraits({
    @Query("identifiers", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
  });

  @override
  @GET("/word/trait/{identifier}")
  Future<HttpResponse<ApiResult<Trait>>> fetchTrait({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/word/trait/{identifier}/word")
  Future<HttpResponse<ApiResult<Word>>> retrieveWordByTrait({
    required String identifier,
  });
}
