import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/word_image.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'image_api.dart';

class ImageService {
  final ImageApi _imageApi = getIt<ImageApi>();

  Future<Either<ErrorResponse, WordImage>> retriveBySku(
    String identifier,
  ) async {
    final HttpResponse<ApiResult<WordImage>> httpResponse = await _imageApi
        .retrieve(identifier: identifier, sku: true, ordinal: false);

    ApiResult<WordImage> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final WordImage payload = apiResult.payload;
      return right(payload);
    } else {
      final ErrorResponse errorResponse = ErrorResponse.fromJson(
        httpResponse.response.data,
      );
      //throw Exception('Failed to retrieve scripts');
      return left(errorResponse);
    }
  }
}
