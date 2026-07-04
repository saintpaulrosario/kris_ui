import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/payload.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'payload_api.dart';

class PayloadService {
  final PayloadApi _payloadApi = getIt<PayloadApi>();

  Future<Either<ErrorResponse, Payload>> retrieveBySku(
    String identifier,
  ) async {
    try {
      final HttpResponse<ApiResult<Payload>> httpResponse = await _payloadApi
          .retrieveByIdentifier(identifier, sku: true, ordinal: false);

      ApiResult<Payload> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Payload payload = apiResult.payload;
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
