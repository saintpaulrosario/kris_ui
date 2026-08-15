import 'package:kris/model/identifier.dart';
import 'package:retrofit/dio.dart';

import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

abstract interface class BaseApi<W, T, C, P> {
  Future<HttpResponse<ApiResult<PageResult<W>>>> fetchAll({
    required int page,
    required int size,
  });

  Future<HttpResponse<ApiResult<W>>> fetch({
   required String identifier
  });

  Future<HttpResponse<ApiResult<T>>> fetchForText({
    required String identifier,
    required Set<String> scripts,
  });

  Future<HttpResponse<ApiResult<C>>> fetchForContent({
    required String identifier,
    required Set<String> languages,
  });

  Future<HttpResponse<ApiResult<P>>> fetchForPayload({
    required String identifier,
    required Set<String> dialects,
  });
}
