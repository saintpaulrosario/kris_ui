import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/data/api/script_api.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/script.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';

class ScriptService {
  final ScriptApi _scriptApi = getIt<ScriptApi>();

  Future<Either<ErrorResponse, Script>> retriveByOrdinal(int ordinal) async {
    final HttpResponse<ApiResult<Script>> httpResponse = await _scriptApi
        .retrieveByIdentifier(ordinal, sku: false, ordinal: true);

    ApiResult<Script> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final Script payload = apiResult.payload;
      return right(payload);
    } else {
      final ErrorResponse errorResponse = ErrorResponse.fromJson(
        httpResponse.response.data,
      );
      //throw Exception('Failed to retrieve scripts');
      return left(errorResponse);
    }
  }

  Future<Either<ErrorResponse, Script>> retriveBySku(String sku) async {
    try {
      final HttpResponse<ApiResult<Script>> httpResponse = await _scriptApi
          .retrieveByIdentifier(sku, sku: true, ordinal: false);

      final ApiResult<Script> apiResult = httpResponse.data;

      if (httpResponse.response.statusCode == 200) {
        final Script script = apiResult.payload;
        return right(script);
      } else {
        return left(ErrorResponse.fromJson(httpResponse.response.data));
      }
    } on DioException catch (e) {
      return left(ErrorResponse(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(ErrorResponse(e.toString()));
    }
  }

  Future<Either<ErrorResponse, List<Script>>> retriveAll() async {
    final HttpResponse<ApiResult<List<Script>>> httpResponse = await _scriptApi
        .retrieveAll();

    ApiResult<List<Script>> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final List<Script> payload = apiResult.payload;
      return right(payload);
    } else {
      final ErrorResponse errorResponse = ErrorResponse.fromJson(
        httpResponse.response.data,
      );
      //throw Exception('Failed to retrieve scripts');
      return left(errorResponse);
    }
  }
}
