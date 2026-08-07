import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/feature/authentication/api/authentication_api.dart';
import 'package:kris/feature/authentication/model/authenticate_request.dart';
import 'package:kris/feature/authentication/model/authenticate_response.dart';

import '../../../../response/error_response.dart';
import '../../../../service_locator.dart';
import '../../model/register_request.dart';
import '../../model/register_response.dart';

class AuthService {
  final api = getIt<AuthenticationApi>();

  Future<Either<ErrorResponse, RegisterResponse>> register(
    RegisterRequest request,
  ) async {
    try {
      final apiResponse = await api.register(request);
      var data = apiResponse.data;
      if (HttpStatus.created == apiResponse.response.statusCode) {
        return Either.right(data.payload);
      } else {
        //final error = ErrorResponse.fromJson(data.payload);
        return Either.left(ErrorResponse.initial());
      }
    } on DioException catch (e) {
      // Optionally log e.response?.data for better insight
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during registration: $e');
    }
  }

  Future<Either<ErrorResponse, AuthenticateResponse>> signIn(
    AuthenticateRequest request,
  ) async {
    try {
      final apiResponse = await api.login(request);
      var data = apiResponse.data;
      if (HttpStatus.ok == apiResponse.response.statusCode) {
        return Either.right(data.payload);
      } else {
        return Either.left(ErrorResponse.initial());
      }
    } on DioException catch (e) {
      // Optionally log e.response?.data for better insight
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during registration: $e');
    }
  }

  // Future<String> validateEmailOTP({
  //   required String email,
  //   required int code,
  // }) async {
  //   try {
  //     final apiResponse = await api.confirmEmail(email, code);
  //     if (HttpStatus.ok == apiResponse.response.statusCode) {
  //       return apiResponse.data;
  //     } else {
  //       throw Exception(apiResponse.data);
  //     }
  //   } on DioException catch (e) {
  //     // Optionally log e.response?.data for better insight
  //     throw Exception('Network error: ${e.message}');
  //   } catch (e) {
  //     throw Exception('Unexpected error during registration: $e');
  //   }
  // }
}
