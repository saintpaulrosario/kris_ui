import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/api/word_detail_api.dart';
import 'package:kris/model/word_detail.dart';
import 'package:kris/response/api_result.dart';
import 'package:kris/service_locator.dart';
import 'package:retrofit/dio.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';

class WordDetailService {
  final WordDetailApi _api = getIt<WordDetailApi>();

  Future<Either<ErrorResponse, PageResult<WordDetail>>> retrieve({
    required int page,
    required int size,
    List<String>? scripts,
    List<String>? languages,
    List<String>? dialects,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<WordDetail>>> httpResponse =
          await _api.fetchAll(
            page: page,
            size: size,
            scripts: scripts,
            dialects: dialects,
            languages: languages,
          );

      ApiResult<PageResult<WordDetail>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final PageResult<WordDetail> payload = apiResult.payload;
        return right(payload);
      } else {
        final ErrorResponse errorResponse = ErrorResponse.fromJson(
          httpResponse.response.data,
        );
        return left(errorResponse);
      }
    } on DioException catch (e) {
      return left(ErrorResponse(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(ErrorResponse(e.toString()));
    }
  }
}
