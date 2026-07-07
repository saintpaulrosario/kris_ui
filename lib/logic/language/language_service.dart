import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/language/language.dart';
import 'package:kris/logic/language/language_api.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';

class LanguageService {
  final LanguageApi _languageApi = getIt<LanguageApi>();

  Future<Either<ErrorResponse, Language>> retrieveBySku(
    String identifier,
  ) async {
    try {
      final HttpResponse<ApiResult<Language>> httpResponse = await _languageApi
          .retrieveBySku(identifier, sku: true, ordinal: false);

      ApiResult<Language> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Language payload = apiResult.payload;
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

  Future<Either<ErrorResponse, List<Language>>> retrieveAll() async {
    try {
      final HttpResponse<ApiResult<List<Language>>> httpResponse =
          await _languageApi.retriveAll(sku: true, ordinal: false);

      ApiResult<List<Language>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final List<Language> payload = apiResult.payload;
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
