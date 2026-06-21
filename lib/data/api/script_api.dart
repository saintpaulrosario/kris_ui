import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/script.dart';
import '../../response/api_result.dart';

part 'script_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class ScriptApi {
  factory ScriptApi(Dio dio, {String baseUrl}) = _ScriptApi;

  @GET("/script")
  Future<HttpResponse<ApiResult<List<Script>>>> retrieveAll();
}
