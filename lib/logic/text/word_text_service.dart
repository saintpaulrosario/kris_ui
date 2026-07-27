import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/identifier.dart';
import 'package:retrofit/dio.dart';
import 'package:uuid/uuid.dart';

import '../error_response.dart';
import 'word_text.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'word_text_api.dart';

class WordTextService {
  final WordTextApi _wordTextApi = getIt<WordTextApi>();

  Future<Either<ErrorResponse, WordText>> retrieveByIdentifier(
    Identifier identifer,
  ) async {
    try {
      final HttpResponse<ApiResult<WordText>> httpResponse = await _wordTextApi
          .retrieveByIdentifier(
            identifier: identifer.sku,
            type: identifer.type,
          );

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
