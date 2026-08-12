import 'package:built_collection/built_collection.dart';

import '../../response/error_response.dart';

class MediumState<M> {
  final BuiltMap<String, ErrorResponse> errors;
  final BuiltSet<String> fetching;
  final BuiltMap<String, M> data;
  final BuiltSet<String> selections;

  MediumState({
    required this.errors,
    required this.fetching,
    required this.data,
    required this.selections,
  });

  factory MediumState.initial() {
    return MediumState(
      errors: BuiltMap<String, ErrorResponse>(),
      data: BuiltMap<String, M>(),
      fetching: BuiltSet<String>(),
      selections: BuiltSet<String>(),
    );
  }

  MediumState<M> copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, M>? data,
    BuiltSet<String>? fetching,
    BuiltSet<String>? selections,
  }) {
    return MediumState<M>(
      errors: errors ?? this.errors,
      data: data ?? this.data,
      fetching: fetching ?? this.fetching,
      selections: selections ?? this.selections,
    );
  }
}
