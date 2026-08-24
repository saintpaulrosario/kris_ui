import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/example.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';

import 'package:retrofit/retrofit.dart';
import '../../../model/example_trait.dart';
import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

part 'example_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class ExampleApi
    implements BaseApi<Example, Text, Content, Payload, ExampleTrait> {
  factory ExampleApi(Dio dio, {String baseUrl}) = _ExampleApi;

  @override
  @GET("/word")
  Future<HttpResponse<ApiResult<PageResult<Example>>>> fetchAll({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("scripts") List<String>? scripts,
    @Query("identifiers") List<String>? identifiers,
  });

  @override
  @GET("/word/{identifier}")
  Future<HttpResponse<ApiResult<Example>>> fetch({
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
  Future<HttpResponse<ApiResult<List<ExampleTrait>>>> fetchTraits({
    @Query("identifiers", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
  });

  @override
  @GET("/word/trait/{identifier}")
  Future<HttpResponse<ApiResult<ExampleTrait>>> fetchTrait({
    @Path("identifier") required String identifier,
  });
}
