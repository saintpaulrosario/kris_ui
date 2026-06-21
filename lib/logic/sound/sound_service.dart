import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/model/sound.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'sound_api.dart';

class SoundService {
  final SoundApi _soundApi = getIt<SoundApi>();

  Future<Either<ErrorResponse, List<Sound>>> retrive(List<String> skus) async {
    try {
      final HttpResponse<ApiResult<List<Sound>>> httpResponse = await _soundApi
          .retrieve(skus);

      ApiResult<List<Sound>> apiResult = httpResponse.data;
      if (httpResponse.response.statusCode == 200) {
        final List<Sound> payload = apiResult.payload;
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
