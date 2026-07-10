import '../model/error_response.dart';

class BaseState<T> {
  final Map<String, ErrorResponse> errors;
  final Map<String, T> data;
  final Set<String> fetching;

  BaseState({required this.errors, required this.fetching, required this.data});

  factory BaseState.initial() {
    return BaseState(errors: {}, fetching: {}, data: {});
  }

  BaseState<T> copyWith({
    Map<String, ErrorResponse>? errors,
    Map<String, T>? data,
    Set<String>? fetching,
  }) {
    return BaseState<T>(
      errors: errors ?? Map.from(this.errors),
      data: data ?? Map.from(this.data),
      fetching: fetching ?? Set.from(this.fetching),
    );
  }
}
