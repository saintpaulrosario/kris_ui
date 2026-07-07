import 'package:dio/dio.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:retrofit/retrofit.dart';
import '../../response/api_result.dart';

part 'dialect_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class DialectApi {
  factory DialectApi(Dio dio, {String baseUrl}) = _DialectApi;

  @GET("/dialect/{identifier}")
  Future<HttpResponse<ApiResult<Dialect>>> retrieveBySku(
    @Path("identifier") String identifier, {
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });

  @GET("/dialect")
  Future<HttpResponse<ApiResult<List<Dialect>>>> retriveAll({
    @Query("sku", encoded: true) required bool sku,
    @Query("ordinal", encoded: true) required bool ordinal,
  });
}
