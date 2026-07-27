import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'example_payload.dart';
import 'example_payload_api.dart';

class ExamplePayloadService {
  final ExamplePayloadApi _api = getIt<ExamplePayloadApi>();

  Future<Either<ErrorResponse, ExamplePayload>> retrieveBySku(
    String identifier,
  ) async {
    try {
      final HttpResponse<ApiResult<ExamplePayload>> httpResponse = await _api
          .retrieveByIdentifier(identifier, sku: true, ordinal: false);

      ApiResult<ExamplePayload> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final ExamplePayload payload = apiResult.payload;
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
