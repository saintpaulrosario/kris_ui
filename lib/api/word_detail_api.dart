import 'package:dio/dio.dart';
import 'package:kris/model/word_detail.dart';
import 'package:kris/response/api_result.dart';
import 'package:kris/response/page_result.dart';
import 'package:retrofit/retrofit.dart';

part 'word_detail_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract class WordDetailApi {
  factory WordDetailApi(Dio dio, {String baseUrl}) = _WordDetailApi;

  @GET("/word/detail")
  Future<HttpResponse<ApiResult<PageResult<WordDetail>>>> fetchAll({
    @Query("page") required int page,
    @Query("size") required int size,
    @Header("scripts") List<String>? scripts,
    @Header("languages") List<String>? languages,
    @Header("dialects") List<String>? dialects,
  });
}
