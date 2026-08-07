import 'package:dio/dio.dart';
import 'package:kris/model/translation_content.dart';
import 'package:kris/model/translation_payload.dart';
import 'package:kris/model/translation_text.dart';
import 'package:retrofit/retrofit.dart';
import '../model/script.dart';
import '../response/api_result.dart';
import '../response/page_result.dart';
import 'word_api.dart';

part 'script_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class ScriptApi
    implements
        WordApi<
          Script,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  factory ScriptApi(Dio dio, {String baseUrl}) = _ScriptApi;

  @override
  @GET("/script")
  Future<HttpResponse<ApiResult<PageResult<Script>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
  });

  @override
  @GET("/script/{identifier}")
  Future<HttpResponse<ApiResult<Script>>> fetch(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/script/text/{identifier}")
  Future<HttpResponse<ApiResult<TranslationText>>> fetchForText(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/script/content/{identifier}")
  Future<HttpResponse<ApiResult<TranslationContent>>> fetchForContent(
    @Path("identifier") String identifier,
  );

  @override
  @GET("/script/payload/{identifier}")
  Future<HttpResponse<ApiResult<TranslationPayload>>> fetchForPayload(
    @Path("identifier") String identifier,
  );
}
