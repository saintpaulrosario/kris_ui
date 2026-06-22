import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/image.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'image_api.dart';

class ImageService {
  final ImageApi _imageApi = getIt<ImageApi>();

  Future<Either<ErrorResponse, Image>> retrive(String sku) async {
    final HttpResponse<ApiResult<Image>> httpResponse = await _imageApi
        .retrieve(identifier: sku, sku: true, ordinal: false);

    ApiResult<Image> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final Image payload = apiResult.payload;
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
