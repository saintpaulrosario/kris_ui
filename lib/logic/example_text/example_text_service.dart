import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/identifier.dart';
import 'package:retrofit/dio.dart';

import '../error_response.dart';
import '../text/word_text.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'example_text.dart';
import 'example_text_api.dart';

class ExampleTextService {
  final ExampleTextApi _wordTextApi = getIt<ExampleTextApi>();

  Future<Either<ErrorResponse, ExampleText>> retrieveByIdentifier(
    Identifier identifer,
  ) async {
    try {
      final HttpResponse<ApiResult<ExampleText>> httpResponse =
          await _wordTextApi.retrieveByIdentifier(
            identifier: identifer.sku,
            type: identifer.type,
          );

      ApiResult<ExampleText> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final ExampleText payload = apiResult.payload;
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
