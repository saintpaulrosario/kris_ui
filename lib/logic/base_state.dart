import '../model/error_response.dart';

class BaseState {
  final bool fetching;
  final bool success;
  final bool failure;
  final String message;
  final ErrorResponse error;

  BaseState({
    required this.fetching,
    required this.success,
    required this.failure,
    required this.message,
    required this.error,
  });

  factory BaseState.initial() {
    return BaseState(
      success: true,
      failure: false,
      message: '',
      fetching: false,
      error: ErrorResponse.initial(),
    );
  }

  BaseState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    bool? failure,
  }) {
    return BaseState(
      error: error ?? this.error,
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      failure: failure ?? this.failure,
    );
  }
}
