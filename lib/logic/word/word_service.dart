import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../error_response.dart';
import 'word.dart';
import '../../response/api_result.dart';
import '../../response/page_result.dart';
import '../../service_locator.dart';
import 'word_api.dart';

class WordService {
  final WordApi _wordApi = getIt<WordApi>();

  Future<Either<ErrorResponse, PageResult<Word>>> retrive({
    required int page,
    required int size,
    String? maya,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<Word>>> httpResponse =
          await _wordApi.retrieveAll(page: page, size: size, maya: maya);

      ApiResult<PageResult<Word>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final PageResult<Word> payload = apiResult.payload;
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

  Future<Either<ErrorResponse, Word>> retrieveWordBySku(String sku) async {
    final HttpResponse<ApiResult<Word>> httpResponse = await _wordApi
        .retrieveBySku(sku, sku: true, ordinal: false);
    try {
      ApiResult<Word> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Word payload = apiResult.payload;
        return right(payload);
      } else {
        final ErrorResponse errorResponse = ErrorResponse.fromJson(
          httpResponse.response.data,
        );
        //throw Exception('Failed to retrieve scripts');
        return left(errorResponse);
      }
    } on DioException catch (e) {
      return left(ErrorResponse(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(ErrorResponse(e.toString()));
    }
  }
}
