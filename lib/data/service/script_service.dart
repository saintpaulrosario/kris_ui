import 'package:kris/data/api/script_api.dart';
import 'package:retrofit/dio.dart';

import '../../model/script.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';

class ScriptService {
  final ScriptApi _scriptApi = getIt<ScriptApi>();

  Future<List<Script>> getScripts() async {
    final HttpResponse<ApiResult<List<Script>>> httpResponse = await _scriptApi
        .retrieveAll();

    if (httpResponse.response.statusCode == 200) {
      final ApiResult<List<Script>> apiResult = httpResponse.response.data;
      final List<Script> scripts = apiResult.payload;
      return scripts;
    } else {
      throw Exception('Failed to load scripts');
    }
  }
}
