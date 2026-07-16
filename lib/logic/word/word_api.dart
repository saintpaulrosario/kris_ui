import 'package:dio/dio.dart';
import 'package:kris/response/page_result.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/word.dart';
import '../../response/api_result.dart';

part 'word_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class WordApi {
  factory WordApi(Dio dio, {String baseUrl}) = _WordApi;

  @GET("/word")
  Future<HttpResponse<ApiResult<PageResult<Word>>>> retrieveAll({
    @Query("page") required int page,
    @Query("size") required int size,
    @Query("maya") String? maya,
    @Query("type") required String type,
  });

  @GET("/word/{identifier}")
  Future<HttpResponse<ApiResult<Word>>> retrieveBySku(
    @Path("identifier") String identifier, {
    @Query("sku") bool? sku,
    @Query("ordinal") bool? ordinal,
  });
}
