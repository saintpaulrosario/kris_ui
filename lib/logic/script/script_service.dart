import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/api/script_api.dart';
import 'package:retrofit/dio.dart';

import '../../api/tranlation_api.dart';
import '../../model/script.dart';
import '../../model/script_content.dart';
import '../../model/script_payload.dart';
import '../../model/script_text.dart';
import '../../response/error_response.dart';
import '../../response/api_result.dart';
import '../../response/page_result.dart';
import '../../service_locator.dart';
import '../word_service.dart';

class ScriptService
    implements WordService<Script, ScriptText, ScriptContent, ScriptPayload> {
  final ScriptApi _api = getIt<ScriptApi>();

  @override
  Future<Either<ErrorResponse, PageResult<Script>>> retrieve({
    required int page,
    required int size,
  }) async {
    try {
      final HttpResponse<ApiResult<PageResult<Script>>> httpResponse =
          await _api.fetchAll(page: page, size: size);

      ApiResult<PageResult<Script>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final PageResult<Script> payload = apiResult.payload;
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
  Future<Either<ErrorResponse, Script>> retrieveWordBySku(String sku) async {
    try {
      final HttpResponse<ApiResult<Script>> httpResponse = await _api.fetch(
        sku,
      );

      ApiResult<Script> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Script payload = apiResult.payload;
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
  Future<Either<ErrorResponse, ScriptText>> retrieveTextBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<ScriptText>> httpResponse = await _api
        .fetchForText(sku);
    try {
      ApiResult<ScriptText> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final ScriptText payload = apiResult.payload;
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
  Future<Either<ErrorResponse, ScriptContent>> retrieveContentBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<ScriptContent>> httpResponse = await _api
        .fetchForContent(sku);
    try {
      ApiResult<ScriptContent> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final ScriptContent payload = apiResult.payload;
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
  Future<Either<ErrorResponse, ScriptPayload>> retrievePayloadBySku(
    String sku,
  ) async {
    final HttpResponse<ApiResult<ScriptPayload>> httpResponse = await _api
        .fetchForPayload(sku);
    try {
      ApiResult<ScriptPayload> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final ScriptPayload payload = apiResult.payload;
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
