import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/word_content.dart';
import '../../model/word_payload.dart';
import '../../model/word_text.dart';
import '../../response/error_response.dart';
import '../../model/word.dart';
import '../../response/api_result.dart';
import '../../response/page_result.dart';
import '../../service_locator.dart';
import '../../api/word_api.dart';

class WordService {
  final WordApi _wordApi = getIt<WordApi>();

  Future<Either<ErrorResponse, PageResult<Word>>> retrive({
    required int page,
    required int size,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<Word>>> httpResponse =
          await _wordApi.fetchAll(page: page, size: size);

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

  Future<Either<ErrorResponse, Word>> retrieveWordBySku(String sku) async {
    final HttpResponse<ApiResult<Word>> httpResponse = await _wordApi.fetch(
      sku,
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

  Future<Either<ErrorResponse, WordText>> retrieveTextBySku(String sku) async {
    final HttpResponse<ApiResult<WordText>> httpResponse = await _wordApi
        .fetchForText(sku);
    try {
      ApiResult<WordText> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final WordText payload = apiResult.payload;
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

  Future<Either<ErrorResponse, WordContent>> retrieveContentBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<WordContent>> httpResponse = await _wordApi
        .fetchForContent(sku);
    try {
      ApiResult<WordContent> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final WordContent payload = apiResult.payload;
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

  Future<Either<ErrorResponse, WordPayload>> retrievePayloadBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<WordPayload>> httpResponse = await _wordApi
        .fetchForPayload(sku);
    try {
      ApiResult<WordPayload> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final WordPayload payload = apiResult.payload;
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
