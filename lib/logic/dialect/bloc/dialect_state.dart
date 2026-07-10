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
      errors: errors ?? Map.from(this.errors),
      fetching: fetching ?? Set.from(this.fetching),
      data: data ?? Map.from(this.data),
    );
  }
}
