import 'package:retrofit/dio.dart';

import '../response/api_result.dart';
import '../response/page_result.dart';

abstract interface class WordApi<W, T, C, P> {
  Future<HttpResponse<ApiResult<PageResult<W>>>> fetchAll({
    required int page,
    required int size,
  });

  Future<HttpResponse<ApiResult<W>>> fetch(String identifier);

  Future<HttpResponse<ApiResult<T>>> fetchForText(String identifier);

  Future<HttpResponse<ApiResult<C>>> fetchForContent(String identifier);

  Future<HttpResponse<ApiResult<P>>> fetchForPayload(String identifier);
}
