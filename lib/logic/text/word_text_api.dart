import 'package:dio/dio.dart';
import 'package:kris/model/word_text.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/sound.dart';
import '../../response/api_result.dart';

part 'word_text_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class WordTextApi {
  factory WordTextApi(Dio dio, {String baseUrl}) = _WordTextApi;

  @GET("/text/{identifier}")
  Future<HttpResponse<ApiResult<WordText>>> retrieve(
    @Path("identifier") String identifier,
    @Query("sku", encoded: true) bool sku,
    @Query("ordinal", encoded: true) bool ordinal,
  );
}
