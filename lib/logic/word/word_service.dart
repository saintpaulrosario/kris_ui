import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/word.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'word_api.dart';

class WordService {
  final WordApi _wordApi = getIt<WordApi>();

  Future<Either<ErrorResponse, List<Word>>> retrive() async {
    try {
      final HttpResponse<ApiResult<List<Word>>> httpResponse = await _wordApi
          .retrieveAll();

      ApiResult<List<Word>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final List<Word> payload = apiResult.payload;
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
  }
}
