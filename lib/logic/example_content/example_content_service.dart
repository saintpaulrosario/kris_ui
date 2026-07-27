import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/example/example.dart';
import 'package:kris/logic/identifier.dart';
import 'package:retrofit/dio.dart';

import '../content/content.dart';
import '../error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'example_content.dart';
import 'example_content_api.dart';

class ExampleContentService {
  final ExampleContentApi _contentApi = getIt<ExampleContentApi>();

  Future<Either<ErrorResponse, ExampleContent>> fetchByIdentifier(
    Identifier identifier,
  ) async {
    try {
      final HttpResponse<ApiResult<ExampleContent>> httpResponse =
          await _contentApi.fetchByIdentifier(identifier.sku);

      ApiResult<ExampleContent> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final ExampleContent payload = apiResult.payload;
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
