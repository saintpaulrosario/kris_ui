import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/word.dart';
import '../../response/api_result.dart';

part 'word_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class WordApi {
  factory WordApi(Dio dio, {String baseUrl}) = _WordApi;

  @GET("/word")
  Future<HttpResponse<ApiResult<List<Word>>>> retrieveAll();

  @GET("/word/identifier")
  Future<HttpResponse<ApiResult<Word>>> retrieveWordBySku({
    @Query("sku") String? sku,
    @Query("ordinal") int? ordinal,
  });
}
