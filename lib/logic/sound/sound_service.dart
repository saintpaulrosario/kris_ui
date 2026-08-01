import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/model/sound.dart';
import 'package:retrofit/dio.dart';

import '../../response/error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'sound_api.dart';

class SoundService {
  final SoundApi _soundApi = getIt<SoundApi>();

  Future<Either<ErrorResponse, Sound>> retriveBySku(String identifier) async {
    try {
      final HttpResponse<ApiResult<Sound>> httpResponse = await _soundApi
          .retrieveBySku(identifier, sku: true, ordinal: false);

      ApiResult<Sound> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final Sound payload = apiResult.payload;
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
