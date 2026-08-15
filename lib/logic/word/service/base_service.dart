import 'package:fpdart/fpdart.dart';
import 'package:kris/model/identifier.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';

abstract class BaseService<W, T, C, P> {
  Future<Either<ErrorResponse, PageResult<W>>> retrieve({
    required int page,
    required int size,
  });

  Future<Either<ErrorResponse, W>> retrieveWordBySku({
    required Identifier identifier,
  });

  Future<Either<ErrorResponse, T>> retrieveTextBySku({
    required Identifier identifier,
    required Set<String> scripts,
  });

  Future<Either<ErrorResponse, C>> retrieveContentBySku({
    required Identifier identifier,
    required Set<String> languages,
  });

  Future<Either<ErrorResponse, P>> retrievePayloadBySku({
    required Identifier identifier,
    required Set<String> dialects,
  });
}
