import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/content.dart';
import '../../response/api_result.dart';
import '../example/example.dart';
import 'example_content.dart';

part 'example_content_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class ExampleContentApi {
  factory ExampleContentApi(Dio dio, {String baseUrl}) = _ExampleContentApi;

  @GET("/example/content/{identifier}")
  Future<HttpResponse<ApiResult<ExampleContent>>> fetchByIdentifier(
    @Path("identifier") String identifier,
  );
}
