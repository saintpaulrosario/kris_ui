part of 'authenticate_bloc.dart';

@immutable
class AuthenticateState extends AuthState {
  final String email;
  final String secret;
  final AuthenticateResponse authenticateResponse;

  const AuthenticateState({
    required this.email,
    required this.secret,
    required this.authenticateResponse,
    required super.fetching,
    required super.success,
    required super.message,
    required super.error,
  });

  factory AuthenticateState.initial() {
    return AuthenticateState(
      email: '',
      secret: '',
      authenticateResponse: AuthenticateResponse.initial(),
      fetching: false,
      success: false,
      message: '',
      error: ErrorResponse.initial(),
    );
  }

  @override
  AuthenticateState copyWith({
    String? email,
    String? secret,
    AuthenticateResponse? authenticateResponse,
    String? refreshToken,
    bool? fetching,
    bool? success,
    String? message,
    ErrorResponse? error,
  }) {
    return AuthenticateState(
      email: email ?? this.email,
      secret: secret ?? this.secret,
      authenticateResponse: authenticateResponse ?? this.authenticateResponse,
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
