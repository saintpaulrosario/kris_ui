import 'package:dio/dio.dart';
import 'package:kris/response/page_result.dart';
import 'package:retrofit/retrofit.dart';
import '../model/word.dart';
import '../model/word_content.dart';
import '../model/word_payload.dart';
import '../model/word_text.dart';
import '../response/api_result.dart';

part 'word_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class WordApi {
  factory WordApi(Dio dio, {String baseUrl}) = _WordApi;

  @GET("/word")
  Future<HttpResponse<ApiResult<PageResult<Word>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
  });

  @GET("/word/{identifier}")
  Future<HttpResponse<ApiResult<Word>>> fetch(
    @Path("identifier") String identifier,
  );

  @GET("/word/text/{identifier}")
  Future<HttpResponse<ApiResult<WordText>>> fetchForText(
    @Path("identifier") String identifier,
  );

  @GET("/word/content/{identifier}")
  Future<HttpResponse<ApiResult<WordContent>>> fetchForContent(
    @Path("identifier") String identifier,
  );

  @GET("/word/payload/{identifier}")
  Future<HttpResponse<ApiResult<WordPayload>>> fetchForPayload(
    @Path("identifier") String identifier,
  );
}
