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
    final HttpResponse<ApiResult<Script>> httpResponse = await _scriptApi
        .retrieveByIdentifier(sku, sku: true, ordinal: false);

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
}
