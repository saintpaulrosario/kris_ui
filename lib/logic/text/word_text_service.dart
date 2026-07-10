import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';
import 'package:uuid/uuid.dart';

import '../../model/error_response.dart';
import '../../model/word_text.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'word_text_api.dart';

class WordTextService {
  final WordTextApi _wordTextApi = getIt<WordTextApi>();

  Future<Either<ErrorResponse, WordText>> retrieveBySku(String sku) async {
    try {
      final HttpResponse<ApiResult<WordText>> httpResponse = await _wordTextApi
          .retrieveBySku(sku);

      ApiResult<WordText> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final WordText payload = apiResult.payload;
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
