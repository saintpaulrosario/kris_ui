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
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<W>>> httpResponse = await _api
          .fetchAll(page: page, size: size);

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

  Future<Either<ErrorResponse, W>> retrieveWordBySku(String sku) async {
    final HttpResponse<ApiResult<W>> httpResponse = await _api.fetch(sku);
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

  Future<Either<ErrorResponse, T>> retrieveTextBySku(String sku) async {
    final HttpResponse<ApiResult<T>> httpResponse = await _api.fetchForText(
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

  Future<Either<ErrorResponse, C>> retrieveContentBySku(String sku) async {
    final HttpResponse<ApiResult<C>> httpResponse = await _api.fetchForContent(
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

  Future<Either<ErrorResponse, P>> retrievePayloadBySku(String sku) async {
    final HttpResponse<ApiResult<P>> httpResponse = await _api.fetchForPayload(
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
