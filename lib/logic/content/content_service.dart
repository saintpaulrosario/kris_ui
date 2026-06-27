import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/content.dart';
import '../../model/error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'content_api.dart';

class ContentService {
  final ContentApi _contentApi = getIt<ContentApi>();

  Future<Either<ErrorResponse, List<Content>>> retriveByTextIdentifier(
    String identifier,
  ) async {
    try {
      final HttpResponse<ApiResult<List<Content>>> httpResponse =
          await _contentApi.retrieveTextBySku(
            identifier,
            sku: true,
            ordinal: false,
          );

      ApiResult<List<Content>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final List<Content> payload = apiResult.payload;
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

  Future<Either<ErrorResponse, Content>> retriveBySku(String identifier) async {
    try {
      final HttpResponse<ApiResult<Content>> httpResponse = await _contentApi
          .retrieveByIdentifier(identifier);

      ApiResult<Content> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Content payload = apiResult.payload;
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
