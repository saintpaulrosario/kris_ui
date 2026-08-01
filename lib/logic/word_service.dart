import 'package:fpdart/fpdart.dart';

import '../api/word_api.dart';
import '../response/error_response.dart';
import '../response/page_result.dart';

abstract class WordService<W, T, C, P> {
  Future<Either<ErrorResponse, PageResult<W>>> retrieve({
    required int page,
    required int size,
  });

  Future<Either<ErrorResponse, W>> retrieveWordBySku(String sku);

  Future<Either<ErrorResponse, T>> retrieveTextBySku(String sku);

  Future<Either<ErrorResponse, C>> retrieveContentBySku(String sku);

  Future<Either<ErrorResponse, P>> retrievePayloadBySku(String sku);
}
