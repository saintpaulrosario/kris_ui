import 'package:bloc/bloc.dart';

import '../../../model/error_response.dart';
import '../../../model/sound.dart';
import '../../../service_locator.dart';
import '../sound_service.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  final _soundService = getIt.get<SoundService>();

  SoundBloc() : super(SoundState.initial()) {
    on<SoundEvent>((event, emit) {});

    on<RetrieveSoundsEvent>((event, emit) async {
      emit(state.copyWith(fetching: true));
      final results = await _soundService.retrive(event.skus);

      results.fold(
        (error) =>
            emit(state.copyWith(fetching: false, success: false, error: error)),
        (success) => emit(
          state.copyWith(fetching: false, success: true, sounds: success),
        ),
      );
    });
  }
}
