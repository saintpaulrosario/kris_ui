import 'package:bloc/bloc.dart';
import 'package:kris/feature/authentication/model/authenticate_request.dart';
import 'package:meta/meta.dart';

import '../../../../../response/error_response.dart';
import '../../../../../service_locator.dart';
import '../../../auth_state.dart';
import '../../../model/authenticate_response.dart';
import '../authenticate_service.dart';

part 'authenticate_event.dart';
part 'authenticate_state.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  final AuthService _service = getIt<AuthService>();

  AuthenticateBloc() : super(AuthenticateState.initial()) {
    on<AuthenticateEvent>((event, emit) async {
      emit(state.copyWith(fetching: true, success: false, message: ''));
      AuthenticateRequest request = AuthenticateRequest(
        principal: event.email,
        secret: event.secret,
      );
      final result = await _service.signIn(request);

      result.match(
        (left) {
          emit(
            state.copyWith(
              fetching: false,
              success: false,
              message: left.message,
              error: left,
            ),
          );
        },
        (right) {
          emit(
            state.copyWith(
              fetching: false,
              success: true,
              authenticateResponse: right,
              message: "authenticate success",
            ),
          );
        },
      );
    });
  }
}
