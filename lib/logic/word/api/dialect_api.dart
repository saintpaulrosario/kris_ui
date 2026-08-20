import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:retrofit/retrofit.dart';
import '../../../model/trait.dart';
import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

part 'dialect_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class DialectApi
    implements BaseApi<Dialect, Text, Content, Payload, Trait> {
  factory DialectApi(Dio dio, {String baseUrl}) = _DialectApi;

  @override
  @GET("/dialect")
  Future<HttpResponse<ApiResult<PageResult<Dialect>>>> fetchAll({
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("scripts") List<String>? scripts,
  });

  @override
  @GET("/dialect/{identifier}")
  Future<HttpResponse<ApiResult<Dialect>>> fetch({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/dialect/text/{identifier}")
  Future<HttpResponse<ApiResult<Text>>> fetchText({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/dialect/text")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Query("identifier") List<String>? identifiers,
    @Query("scripts") List<String>? scripts,
  });

  @override
  @GET("/dialect/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/dialect/content")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Path("identifier") List<String>? identifiers,
    @Query("languages") List<String>? languages,
  });

  @override
  @GET("/dialect/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/dialect/payload")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Query("identifier", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
    @Query("scripts", encoded: true) List<String>? scripts,
    @Query("languages", encoded: true) List<String>? languages,
  });

  @override
  @GET("/dialect/trait")
  Future<HttpResponse<ApiResult<List<Trait>>>> fetchTraits({
    @Query("identifiers", encoded: true) List<String>? identifiers,
    @Query("dialects", encoded: true) List<String>? dialects,
  });

  @override
  @GET("/dialect/trait/{identifier}")
  Future<HttpResponse<ApiResult<Trait>>> fetchTrait({
    @Path("identifier") required String identifier,
  });
}
