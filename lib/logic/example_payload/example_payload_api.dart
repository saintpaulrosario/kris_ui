import 'package:dio/dio.dart';
import 'package:kris/logic/text/word_text.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uuid/uuid.dart';
import '../payload/payload.dart';
import '../sound/sound.dart';
import '../../response/api_result.dart';
import 'example_payload.dart';

part 'example_payload_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class ExamplePayloadApi {
  factory ExamplePayloadApi(Dio dio, {String baseUrl}) = _ExamplePayloadApi;

  @GET("/payload/example/{identifier}")
  Future<HttpResponse<ApiResult<ExamplePayload>>> retrieveByIdentifier(
    @Path("identifier") String identifier, {
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });
}
