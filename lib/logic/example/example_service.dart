import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/logic/example/example_api.dart';
import 'package:kris/model/identifier.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/word.dart';
import '../../response/api_result.dart';
import '../../response/page_result.dart';
import '../../service_locator.dart';

class ExampleService {
  final ExampleApi _exampleApi = getIt<ExampleApi>();

  Future<Either<ErrorResponse, Example>> retrieveByIdentifier(
    Identifier identifier,
  ) async {
    final HttpResponse<ApiResult<Example>> httpResponse = await _exampleApi
        .retrieveByIdentifier(identifier.sku, sku: true, ordinal: false);
    try {
      ApiResult<Example> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Example payload = apiResult.payload;
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
