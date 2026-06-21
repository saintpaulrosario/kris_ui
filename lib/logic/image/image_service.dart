import 'package:fpdart/fpdart.dart';
import 'package:retrofit/dio.dart';

import '../../model/error_response.dart';
import '../../model/image.dart';
import '../../response/api_result.dart';
import '../../service_locator.dart';
import 'image_api.dart';

class ImageService {
  final ImageApi _imageApi = getIt<ImageApi>();

  Future<Either<ErrorResponse, List<Image>>> retrive(List<String> skus) async {
    final HttpResponse<ApiResult<List<Image>>> httpResponse = await _imageApi
        .retrieve(skus);

    ApiResult<List<Image>> apiResult = httpResponse.data;
    if (httpResponse.response.statusCode == 200) {
      final List<Image> payload = apiResult.payload;
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
