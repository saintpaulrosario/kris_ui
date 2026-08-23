part of 'user_account_bloc.dart';

class UserAccountEvent {}

class UserAccountEventAuthenticated extends UserAccountEvent {
  final String accessToken;

  UserAccountEventAuthenticated({required this.accessToken});
}
