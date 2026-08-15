import 'package:fpdart/fpdart.dart';
import 'package:kris/model/identifier.dart';

import '../../../response/error_response.dart';
import '../../../response/page_result.dart';

abstract class BaseService<W, T, C, P> {
  Future<Either<ErrorResponse, PageResult<W>>> retrieve({
    required int page,
    required int size,
  });

  Future<Either<ErrorResponse, W>> retrieveWord({
    required Identifier identifier,
  });

  Future<Either<ErrorResponse, T>> retrieveText({
    required Identifier identifier,
  });

  Future<Either<ErrorResponse, C>> retrieveContent({
    required Identifier identifier,
  });

  Future<Either<ErrorResponse, P>> retrievePayload({
    required Identifier identifier,
  });

  Future<Either<ErrorResponse, List<T>>> retrieveTexts({
    required List<Identifier> identifiers,
    required List<String>? scripts,
  });

  Future<Either<ErrorResponse, List<C>>> retrieveContents({
    required List<Identifier> identifiers,
    required List<String>? languages,
  });

  Future<Either<ErrorResponse, List<P>>> retrievePayloads({
    required List<Identifier> identifiers,
    required List<String>? dialects,
  });
}
