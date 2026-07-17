import 'package:dio/dio.dart';
import 'package:kris/model/word_text.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uuid/uuid.dart';
import '../../model/sound.dart';
import '../../response/api_result.dart';

part 'word_text_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class WordTextApi {
  factory WordTextApi(Dio dio, {String baseUrl}) = _WordTextApi;

  @GET("/text/{identifier}")
  Future<HttpResponse<ApiResult<WordText>>> retrieveByIdentifier({
    @Path("identifier") required String identifier,
    @Query("type", encoded: true) required String type,
  });

  @GET("/text/word/{identifier}")
  Future<HttpResponse<ApiResult<List<WordText>>>> retriveByWordIdentifier(
    @Path("identifier") String identifier, {
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });

  @GET("/text/{textIdentifier}/word{wordIdentifier}")
  Future<HttpResponse<ApiResult<WordText>>> retriveByTextAndWordIdentifier(
    @Path("textIdentifier") String textIdentifier,
    @Path("wordIdentifier") String wordIdentifier, {
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });
}
