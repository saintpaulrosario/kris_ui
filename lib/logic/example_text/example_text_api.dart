import 'package:dio/dio.dart';
import 'package:kris/model/word_text.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uuid/uuid.dart';
import '../../response/api_result.dart';
import 'example_text.dart';

part 'example_text_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class ExampleTextApi {
  factory ExampleTextApi(Dio dio, {String baseUrl}) = _ExampleTextApi;

  @GET("/example/text/{identifier}")
  Future<HttpResponse<ApiResult<ExampleText>>> retrieveByIdentifier({
    @Path("identifier") required String identifier,
    @Query("type", encoded: true) required String type,
  });
}
