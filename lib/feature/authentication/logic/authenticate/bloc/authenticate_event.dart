part of 'authenticate_bloc.dart';

class AuthenticateEvent {
  final String email;
  final String secret;

  AuthenticateEvent({required this.email, required this.secret});
}
