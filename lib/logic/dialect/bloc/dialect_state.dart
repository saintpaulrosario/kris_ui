part of 'dialect_bloc.dart';

class DialectState extends BaseState<Dialect> {
  DialectState({
    required super.errors,
    required super.fetching,
    required super.data,
  });
  factory DialectState.initial() {
    return DialectState(errors: {}, fetching: {}, data: {});
  }

  @override
  DialectState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Dialect>? data,
  }) {
    return DialectState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
    );
  }
}
