import 'package:built_collection/built_collection.dart';

import 'error_response.dart';

class BaseState<T> {
  final BuiltMap<String, ErrorResponse> errors;
  final BuiltMap<String, T> data;
  final BuiltSet<String> fetching;
  final BuiltSet<T> selections;

  BaseState({
    required this.errors,
    required this.fetching,
    required this.data,
    required this.selections,
  });

  factory BaseState.initial() {
    return BaseState(
      errors: BuiltMap<String, ErrorResponse>(),
      data: BuiltMap<String, T>(),
      fetching: BuiltSet<String>(),
      selections: BuiltSet<T>(),
    );
  }

  BaseState<T> copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltMap<String, T>? data,
    BuiltSet<String>? fetching,
    BuiltSet<T>? selections,
  }) {
    return BaseState<T>(
      errors: errors ?? this.errors,
      data: data ?? this.data,
      fetching: fetching ?? this.fetching,
      selections: selections ?? this.selections,
    );
  }
}
