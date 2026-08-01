import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../api/tranlation_api.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
import '../../response/error_response.dart';
import '../../model/translation.dart';
import '../../response/api_result.dart';
import '../../response/page_result.dart';
import '../../service_locator.dart';
import '../word_service.dart';

class TranslationService
    implements
        WordService<
          Translation,
          TranslationText,
          TranslationContent,
          TranslationPayload
        > {
  final TranslationApi _api = getIt<TranslationApi>();

  @override
  Future<Either<ErrorResponse, PageResult<Translation>>> retrieve({
    required int page,
    required int size,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<Translation>>> httpResponse =
          await _api.fetchAll(page: page, size: size);

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
  Future<Either<ErrorResponse, Translation>> retrieveWordBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<Translation>> httpResponse = await _api.fetch(
      sku,
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
  Future<Either<ErrorResponse, TranslationText>> retrieveTextBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<TranslationText>> httpResponse = await _api
        .fetchForText(sku);
    try {
      ApiResult<TranslationText> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final TranslationText payload = apiResult.payload;
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
  Future<Either<ErrorResponse, TranslationContent>> retrieveContentBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<TranslationContent>> httpResponse = await _api
        .fetchForContent(sku);
    try {
      ApiResult<TranslationContent> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final TranslationContent payload = apiResult.payload;
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
  Future<Either<ErrorResponse, TranslationPayload>> retrievePayloadBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<TranslationPayload>> httpResponse = await _api
        .fetchForPayload(sku);
    try {
      ApiResult<TranslationPayload> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final TranslationPayload payload = apiResult.payload;
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
