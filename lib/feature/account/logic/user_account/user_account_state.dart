part of 'user_account_bloc.dart';

class UserAccountState {
  final bool authenticated;
  final String accessToken;
  final String refreshToken;

  UserAccountState({
    required this.authenticated,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserAccountState.initial() {
    return UserAccountState(
      authenticated: false,
      accessToken: '',
      refreshToken: '',
    );
  }

  UserAccountState copyWith({
    bool? authenticated,
    String? accessToken,
    String? refreshToken,
  }) {
    return UserAccountState(
      authenticated: authenticated ?? this.authenticated,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
