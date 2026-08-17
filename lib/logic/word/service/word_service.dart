import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/word/api/word_api.dart';
import 'package:kris/logic/word/service/base_service.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:kris/model/word.dart';
import 'package:kris/response/api_result.dart';
import 'package:kris/service_locator.dart';
import 'package:retrofit/dio.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';

class WordService extends BaseService<Word, Text, Content, Payload> {
  final WordApi _api = getIt<WordApi>();

  @override
  Future<Either<ErrorResponse, PageResult<Word>>> retrieve({
    int? page,
    int? size,
    List<String>? scripts,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<Word>>> httpResponse = await _api
          .fetchAll(page: page, size: size, scripts: scripts);

      ApiResult<PageResult<Word>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final PageResult<Word> payload = apiResult.payload;
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
  Future<Either<ErrorResponse, Word>> retrieveWord({
    required Identifier identifier,
  }) async {
    final HttpResponse<ApiResult<Word>> httpResponse = await _api.fetch(
      identifier: identifier.sku,
    );
    try {
      ApiResult<Word> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Word payload = apiResult.payload;
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
  Future<Either<ErrorResponse, List<Content>>> retrieveContents({
    required List<Identifier> identifiers,
    required List<String>? scripts,
    required List<String>? languages,
  }) async {
    try {
      List<String> skus = identifiers.map((x) => x.sku).toList();
      final HttpResponse<ApiResult<List<Content>>> httpResponse = await _api
          .fetchContents(
            identifiers: skus,
            scripts: scripts,
            languages: languages,
          );
      ApiResult<List<Content>> apiResult = httpResponse.data;
      if (HttpStatus.ok == httpResponse.response.statusCode) {
        final List<Content> payload = apiResult.payload;
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
    required List<String>? scripts,
    required List<String>? languages,
    required List<String>? dialects,
  }) async {
    try {
      List<String> skus = identifiers.map((x) => x.sku).toList();
      final HttpResponse<ApiResult<List<Payload>>> httpResponse = await _api
          .fetchPayloads(
            identifiers: skus,
            scripts: scripts,
            languages: languages,
          );
      ApiResult<List<Payload>> apiResult = httpResponse.data;
      if (HttpStatus.ok == httpResponse.response.statusCode) {
        final List<Payload> payload = apiResult.payload;
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
  Future<Either<ErrorResponse, List<Text>>> retrieveTexts({
    required List<Identifier> identifiers,
    required List<String>? scripts,
  }) async {
    try {
      List<String> skus = identifiers.map((x) => x.sku).toList();
      final HttpResponse<ApiResult<List<Text>>> httpResponse = await _api
          .fetchTexts(identifiers: skus, scripts: scripts);
      ApiResult<List<Text>> apiResult = httpResponse.data;
      if (HttpStatus.ok == httpResponse.response.statusCode) {
        final List<Text> payload = apiResult.payload;
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
}
