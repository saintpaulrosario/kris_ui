import 'package:dio/dio.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/model/word_text.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uuid/uuid.dart';
import '../../model/sound.dart';
import '../../response/api_result.dart';

part 'example_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class ExampleApi {
  factory ExampleApi(Dio dio, {String baseUrl}) = _ExampleApi;

  @GET("/example/{identifier}")
  Future<HttpResponse<ApiResult<Example>>> retrieveBySku(
    @Path("identifier") String identifier, {
    @Query("sku") required bool sku,
    @Query("ordinal") required bool ordinal,
  });
}
