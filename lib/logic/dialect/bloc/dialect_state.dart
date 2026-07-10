part of 'dialect_bloc.dart';

class DialectState extends BaseState<Dialect> {
  DialectState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory DialectState.initial() {
    return DialectState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Dialect>(),
      selections: BuiltSet<Dialect>(),
    );
  }

  @override
  DialectState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Dialect>? data,
    BuiltSet<Dialect>? selections,
  }) {
    return DialectState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
