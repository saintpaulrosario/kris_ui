import '../model/error_response.dart';

class BaseState {
  final Map<String, ErrorResponse> errors;
  final Set<String> fetching;

  BaseState({required this.errors, required this.fetching});

  factory BaseState.initial() {
    return BaseState(errors: {}, fetching: {});
  }

  BaseState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
  }) {
    return BaseState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
    );
  }
}
