import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../response/api_result.dart';
import '../response/page_result.dart';

part 'word_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074")
abstract interface class WordApi<W, T, C, P> {
  factory WordApi(Dio dio, {String baseUrl}) = _WordApi;

  @GET("/{endpoint}")
  Future<HttpResponse<ApiResult<PageResult<W>>>> fetchAll(
    @Path("endpoint") String endpoint,
    @Query("page") int page,
    @Query("size") int size,
  );

  @GET("/{endpoint}/{sku}")
  Future<HttpResponse<ApiResult<W>>> fetch(
    @Path("endpoint") String endpoint,
    @Path("sku") String sku,
  );

  @GET("/{endpoint}/text/{sku}")
  Future<HttpResponse<ApiResult<T>>> fetchForText(
    @Path("endpoint") String endpoint,
    @Path("sku") String sku,
  );

  @GET("/{endpoint}/content/{sku}")
  Future<HttpResponse<ApiResult<C>>> fetchForContent(
    @Path("endpoint") String endpoint,
    @Path("sku") String sku,
  );

  @GET("/{endpoint}/payload/{sku}")
  Future<HttpResponse<ApiResult<P>>> fetchForPayload(
    @Path("endpoint") String endpoint,
    @Path("sku") String sku,
  );
}
