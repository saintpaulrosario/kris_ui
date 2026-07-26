import 'package:dio/dio.dart';
import 'package:kris/logic/text/word_text.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uuid/uuid.dart';
import '../../model/payload.dart';
import '../../model/sound.dart';
import '../../response/api_result.dart';

part 'payload_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class PayloadApi {
  factory PayloadApi(Dio dio, {String baseUrl}) = _PayloadApi;

  @GET("/payload/{identifier}")
  Future<HttpResponse<ApiResult<Payload>>> retrieveByIdentifier(
    @Path("identifier") String identifier, {
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });
}
