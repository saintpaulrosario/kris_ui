import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/logic/example/example_api.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';

class ExampleService {
  final ExampleApi _exampleApi = getIt<ExampleApi>();

  Future<Either<ErrorResponse, Example>> retrieveBySku(
    String identifier,
  ) async {
    try {
      final HttpResponse<ApiResult<Example>> httpResponse = await _exampleApi
          .retrieveBySku(identifier, sku: true, ordinal: false);

      ApiResult<Example> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Example payload = apiResult.payload;
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
