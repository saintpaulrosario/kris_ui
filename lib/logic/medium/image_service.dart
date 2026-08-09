import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/word_image.dart';
import '../../response/error_response.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'image_api.dart';

class ImageService<W> {
  final ImageApi _imageApi = getIt<ImageApi>();

  Future<Either<ErrorResponse, WordImage>> retriveBySku(
    String identifier,
  ) async {
    final HttpResponse<ApiResult<dynamic>> httpResponse = await _imageApi
        .retrieve(identifier: identifier, sku: true, ordinal: false);

    ApiResult<dynamic> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final dynamic payload = apiResult.payload;
      if (WordImage == W) {
        final WordImage image = WordImage.fromJson(payload);
        return right(image);
      }
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
