import 'package:retrofit/dio.dart';

import '../../../response/api_result.dart';
import '../../../response/page_result.dart';

abstract interface class BaseApi<W, T, C, P> {
  Future<HttpResponse<ApiResult<PageResult<W>>>> fetchAll({
    int? page,
    int? size,
    List<String>? scripts,
  });

  Future<HttpResponse<ApiResult<W>>> fetch({required String identifier});

  Future<HttpResponse<ApiResult<T>>> fetchText({required String identifier});

  Future<HttpResponse<ApiResult<List<T>>>> fetchTexts({
    List<String>? identifiers,
    List<String>? scripts,
  });

  Future<HttpResponse<ApiResult<C>>> fetchContent({required String identifier});

  Future<HttpResponse<ApiResult<List<C>>>> fetchContents({
    List<String>? identifiers,
    List<String>? languages,
  });

  Future<HttpResponse<ApiResult<P>>> fetchPayload({required String identifier});

  Future<HttpResponse<ApiResult<List<P>>>> fetchPayloads({
    List<String>? identifiers,
    List<String>? dialects,
    List<String>? languages,
    List<String>? scripts,
  });
}
