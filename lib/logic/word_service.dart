import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/response/api_result.dart';
import 'package:retrofit/dio.dart';

import '../api/word_api.dart';
import '../response/error_response.dart';
import '../response/page_result.dart';

class WordService<W, T, C, P> {
  final WordApi<W, T, C, P> _api;

  WordService(this._api);
  Future<Either<ErrorResponse, PageResult<W>>> retrieve({
    required int page,
    required int size,
    required endpoint,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<W>>> httpResponse = await _api
          .fetchAll(endpoint, page, size);

      ApiResult<PageResult<W>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final PageResult<W> payload = apiResult.payload;
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

  Future<Either<ErrorResponse, W>> retrieveWordBySku({
    required String sku,
    required String endpoint,
  }) async {
    final HttpResponse<ApiResult<W>> httpResponse = await _api.fetch(
      endpoint,
      sku,
    );
    try {
      ApiResult<W> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final W payload = apiResult.payload;
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

  Future<Either<ErrorResponse, T>> retrieveTextBySku({
    required String endpoint,
    required String sku,
  }) async {
    final HttpResponse<ApiResult<T>> httpResponse = await _api.fetchForText(
      endpoint,
      sku,
    );
    try {
      ApiResult<T> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final T payload = apiResult.payload;
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

  Future<Either<ErrorResponse, C>> retrieveContentBySku({
    required String sku,
    required String endpoint,
  }) async {
    final HttpResponse<ApiResult<C>> httpResponse = await _api.fetchForContent(
      endpoint,
      sku,
    );
    try {
      ApiResult<C> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final C payload = apiResult.payload;
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

  Future<Either<ErrorResponse, P>> retrievePayloadBySku({
    required String sku,
    required String endpoint,
  }) async {
    final HttpResponse<ApiResult<P>> httpResponse = await _api.fetchForPayload(
      endpoint,
      sku,
    );
    try {
      ApiResult<P> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final P payload = apiResult.payload;
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
