import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/medium/medium_api.dart';
import 'package:kris/model/medium.dart';
import 'package:retrofit/dio.dart';

import '../../../response/api_result.dart';
import '../../../response/error_response.dart';
import '../../../service_locator.dart';

class MediumService<W> {
  final MediumApi _api = getIt<MediumApi>();

  Future<Either<ErrorResponse, Medium>> retriveBySku(String identifier) async {
    final HttpResponse<ApiResult<Medium>> httpResponse = await _api.fetch(
      identifier: identifier,
      sku: true,
      ordinal: false,
    );

    ApiResult<Medium> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final Medium payload = apiResult.payload;
      return right(payload);
    } else {
      final ErrorResponse errorResponse = ErrorResponse.fromJson(
        httpResponse.response.data,
      );
      //throw Exception('Failed to retrieve scripts');
      return left(errorResponse);
    }
  }

  Future<Either<ErrorResponse, List<Medium>>> fetch({
    List<String>? identifiers,
  }) async {
    try {
      final HttpResponse<ApiResult<List<Medium>>> httpResponse = await _api
          .fetchAll(identifiers: identifiers);

      ApiResult<List<Medium>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final List<Medium> payload = apiResult.payload;
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
