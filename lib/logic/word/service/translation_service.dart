import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/word/api/translation_api.dart';
import 'package:kris/logic/word/service/base_service.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/response/api_result.dart';
import 'package:kris/service_locator.dart';
import 'package:retrofit/dio.dart';

import '../../../model/translation_trait.dart';
import '../../../response/error_response.dart';
import '../../../response/page_result.dart';

class TranslationService
    extends BaseService<Translation, Text, Content, Payload, TranslationTrait> {
  final TranslationApi _api = getIt<TranslationApi>();

  @override
  Future<Either<ErrorResponse, PageResult<Translation>>> retrieve({
    int? page,
    int? size,
    List<String>? scripts,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<Translation>>> httpResponse =
          await _api.fetchAll(page: page, size: size, scripts: scripts);

      ApiResult<PageResult<Translation>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final PageResult<Translation> payload = apiResult.payload;
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
  Future<Either<ErrorResponse, Translation>> retrieveWord({
    required Identifier identifier,
  }) async {
    final HttpResponse<ApiResult<Translation>> httpResponse = await _api.fetch(
      identifier: identifier.sku,
    );
    try {
      ApiResult<Translation> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Translation payload = apiResult.payload;
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

  @override
  Future<Either<ErrorResponse, List<Payload>>> retrievePayloads({
    required List<Identifier> identifiers,
    required List<String>? dialects,
    required List<String>? scripts,
    required List<String>? languages,
  }) {
    // TODO: implement retrievePayloads
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorResponse, TranslationTrait>> retrieveTrait({
    required Identifier identifier,
  }) {
    // TODO: implement retrieveTrait
    throw UnimplementedError();
  }

  @override
  Future<Either<ErrorResponse, List<TranslationTrait>>> retrieveTraits({
    required List<Identifier> identifiers,
    required List<String>? dialects,
  }) async {
    try {
      final List<String> ids = identifiers.map((x) => x.sku).toList();
      final HttpResponse<ApiResult<List<TranslationTrait>>> httpResponse =
          await _api.fetchTraits(identifiers: ids, dialects: dialects);
      ApiResult<List<TranslationTrait>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final List<TranslationTrait> payload = apiResult.payload;
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
    } finally {
      // log
    }
  }

  @override
  Future<Either<ErrorResponse, Translation>> retrieveWordByTrait({
    required Identifier identifier,
  }) async {
    try {
      final HttpResponse<ApiResult<Translation>> httpResponse = await _api
          .retrieveWordByTrait(identifier: identifier.sku);
      ApiResult<Translation> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Translation payload = apiResult.payload;
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
