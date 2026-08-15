import 'package:retrofit/dio.dart';

import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

abstract interface class BaseApi<W, T, C, P> {
  Future<HttpResponse<ApiResult<PageResult<W>>>> fetchAll({
    required int page,
    required int size,
  });

  Future<HttpResponse<ApiResult<W>>> fetch({required String identifier});

  Future<HttpResponse<ApiResult<T>>> fetchText({required String identifier});

  Future<HttpResponse<ApiResult<List<T>>>> fetchTexts({
    required List<String> identifiers,
    Set<String>? scripts,
  });

  Future<HttpResponse<ApiResult<C>>> fetchContent({required String identifier});

  Future<HttpResponse<ApiResult<List<C>>>> fetchContents({
    required List<String> identifiers,
    Set<String>? languages,
  });

  Future<HttpResponse<ApiResult<P>>> fetchPayload({
    required String identifier,
  });

  Future<HttpResponse<ApiResult<List<P>>>> fetchPayloads({
    required List<String> identifiers,
    Set<String>? dialects,
  });
}
