import 'package:fpdart/fpdart.dart';
import 'package:kris/data/api/script_api.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/script.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';

class ScriptService {
  final ScriptApi _scriptApi = getIt<ScriptApi>();

  Future<Either<ErrorResponse, List<Script>>> retrive() async {
    final HttpResponse<ApiResult<List<Script>>> httpResponse = await _scriptApi
        .retrieveAll();

    ApiResult<List<Script>> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final List<Script> payload = apiResult.payload;
      // final List<Script> scripts = (payload)
      //     .map((e) => Script.fromJson(e))
      //     .toList();

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
