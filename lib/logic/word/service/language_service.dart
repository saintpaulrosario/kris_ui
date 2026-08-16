import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/word/api/language_api.dart';
import 'package:kris/logic/word/service/base_service.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:kris/response/api_result.dart';
import 'package:kris/service_locator.dart';
import 'package:retrofit/dio.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';

class LanguageService extends BaseService<Language, Text, Content, Payload> {
  final LanguageApi _api = getIt<LanguageApi>();

  @override
  Future<Either<ErrorResponse, PageResult<Language>>> retrieve({
    required int page,
    required int size,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<Language>>> httpResponse =
          await _api.fetchAll(page: page, size: size);

      ApiResult<PageResult<Language>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final PageResult<Language> payload = apiResult.payload;
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

  @override
  Future<Either<ErrorResponse, Language>> retrieveWord({
    required Identifier identifier,
  }) async {
    final HttpResponse<ApiResult<Language>> httpResponse = await _api.fetch(
      identifier: identifier.sku,
    );
    try {
      ApiResult<Language> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Language payload = apiResult.payload;
        return right(payload);
      } else {
        final ErrorResponse errorResponse = ErrorResponse.fromJson(
          httpResponse.response.data,
        );
        //throw Exception('Failed to retrieve scripts');
        return left(errorResponse);
      }
    } on DioException catch (e) {
      return left(ErrorResponse(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(ErrorResponse(e.toString()));
    }
  }

  @override
  Future<Either<ErrorResponse, Text>> retrieveText({
    required Identifier identifier,
  }) async {
    final HttpResponse<ApiResult<Text>> httpResponse = await _api.fetchText(
      identifier: identifier.sku,
    );
    try {
      ApiResult<Text> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Text payload = apiResult.payload;
        return right(payload);
      } else {
        final ErrorResponse errorResponse = ErrorResponse.fromJson(
          httpResponse.response.data,
        );
        //throw Exception('Failed to retrieve scripts');
        return left(errorResponse);
      }
    } on DioException catch (e) {
      return left(ErrorResponse(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(ErrorResponse(e.toString()));
    }
  }

  @override
  Future<Either<ErrorResponse, Content>> retrieveContent({
    required Identifier identifier,
  }) async {
    final HttpResponse<ApiResult<Content>> httpResponse = await _api
        .fetchContent(identifier: identifier.sku);
    try {
      ApiResult<Content> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Content payload = apiResult.payload;
        return right(payload);
      } else {
        final ErrorResponse errorResponse = ErrorResponse.fromJson(
          httpResponse.response.data,
        );
        //throw Exception('Failed to retrieve scripts');
        return left(errorResponse);
      }
    } on DioException catch (e) {
      return left(ErrorResponse(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(ErrorResponse(e.toString()));
    }
  }

  @override
  Future<Either<ErrorResponse, Payload>> retrievePayload({
    required Identifier identifier,
  }) async {
    final HttpResponse<ApiResult<Payload>> httpResponse = await _api
        .fetchPayload(identifier: identifier.sku);
    try {
      ApiResult<Payload> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Payload payload = apiResult.payload;
        return right(payload);
      } else {
        final ErrorResponse errorResponse = ErrorResponse.fromJson(
          httpResponse.response.data,
        );
        //throw Exception('Failed to retrieve scripts');
        return left(errorResponse);
      }
    } on DioException catch (e) {
      return left(ErrorResponse(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(ErrorResponse(e.toString()));
    }
  }

  @override
  Future<Either<ErrorResponse, List<Payload>>> retrievePayloads({
    required List<Identifier> identifiers,
    required List<String>? dialects,
  }) {
    // TODO: implement retrievePayloads
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorResponse, List<Text>>> retrieveTexts({
    required List<Identifier> identifiers,
    required List<String>? scripts,
  }) {
    // TODO: implement retrieveTexts
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorResponse, List<Content>>> retrieveContents({
    required List<Identifier> identifiers,
    required List<String>? scripts,
    required List<String>? languages,
  }) {
    // TODO: implement retrieveContents
    throw UnimplementedError();
  }
}
