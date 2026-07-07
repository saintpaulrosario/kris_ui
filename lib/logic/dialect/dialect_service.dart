import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:kris/logic/dialect/dialect_api.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';

class DialectService {
  final DialectApi _dialectApi = getIt<DialectApi>();

  Future<Either<ErrorResponse, Dialect>> retrieveBySku(
    String identifier,
  ) async {
    try {
      final HttpResponse<ApiResult<Dialect>> httpResponse = await _dialectApi
          .retrieveBySku(identifier, sku: true, ordinal: false);

      ApiResult<Dialect> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Dialect payload = apiResult.payload;
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

  Future<Either<ErrorResponse, List<Dialect>>> retrieveAll() async {
    try {
      final HttpResponse<ApiResult<List<Dialect>>> httpResponse =
          await _dialectApi.retriveAll(sku: true, ordinal: false);

      ApiResult<List<Dialect>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final List<Dialect> payload = apiResult.payload;
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
