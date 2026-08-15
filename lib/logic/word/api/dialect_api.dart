import 'package:dio/dio.dart';
import 'package:kris/logic/word/api/base_api.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:retrofit/retrofit.dart';
import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

part 'dialect_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class DialectApi implements BaseApi<Dialect, Text, Content, Payload> {
  factory DialectApi(Dio dio, {String baseUrl}) = _DialectApi;

  @override
  @GET("/dialect")
  Future<HttpResponse<ApiResult<PageResult<Dialect>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
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
  @GET("/dialect/text/{identifier}")
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    @Path("identifier") required List<String> identifiers,
    @Header("scripts") Set<String>? scripts,
  });

  @override
  @GET("/dialect/content/{identifier}")
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/dialect/content/{identifier}")
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    @Path("identifier") required List<String> identifiers,
    @Header("languages") Set<String>? languages,
  });

  @override
  @GET("/dialect/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    @Path("identifier") required String identifier,
  });

  @override
  @GET("/dialect/payload/{identifier}")
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    @Path("identifier") required List<String> identifiers,
    @Header("dialects") Set<String>? dialects,
  });
}
