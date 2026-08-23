import 'package:bloc/bloc.dart';

part 'user_account_event.dart';
part 'user_account_state.dart';

class UserAccountBloc extends Bloc<UserAccountEvent, UserAccountState> {
  UserAccountBloc() : super(UserAccountState.initial()) {
    on<UserAccountEvent>((event, emit) {});

    on<UserAccountEventAuthenticated>((event, emit) {
      emit(state.copyWith(accessToken: event.accessToken, authenticated: true));
    });
  }
}
