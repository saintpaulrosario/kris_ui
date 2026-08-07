import 'dart:async';

import 'package:kris/feature/authentication/model/authenticate_request.dart';
import 'package:kris/feature/authentication/model/authenticate_response.dart';
import 'package:kris/feature/authentication/model/register_request.dart';
import 'package:kris/feature/authentication/model/register_response.dart';
import 'package:kris/response/api_result.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'authentication_api.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8074") // Replace with your API
abstract class AuthenticationApi {
  factory AuthenticationApi(Dio dio, {String baseUrl}) = _AuthenticationApi;

  @POST("/account")
  Future<HttpResponse<ApiResult<RegisterResponse>>> register(
    @Body() RegisterRequest request,
  );

  @POST("/authentication")
  Future<HttpResponse<ApiResult<AuthenticateResponse>>> login(
    @Body() AuthenticateRequest request,
  );

  @GET("/otp/{email}/confirm")
  Future<HttpResponse<ApiResult<String>>> confirmEmail(
    @Path("email") String email,
    @Query("code", encoded: true) int code,
  );
}
