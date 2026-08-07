import '../../response/error_response.dart';

class AuthState {
  final bool success;
  final String message;
  final bool fetching;
  final ErrorResponse error;

  const AuthState({
    required this.success,
    required this.message,
    required this.fetching,
    required this.error,
  });

  factory AuthState.initial() {
    return AuthState(
      success: false,
      message: '',
      fetching: false,
      error: ErrorResponse.initial(),
    );
  }

  AuthState copyWith({
    bool? success,
    String? message,
    ErrorResponse? error,
    bool? fetching,
  }) {
    return AuthState(
      success: success ?? this.success,
      message: message ?? this.message,
      fetching: fetching ?? this.fetching,
      error: error ?? this.error,
    );
  }
}
