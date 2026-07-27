import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:kris/logic/base_state.dart';

import '../../error_response.dart';
import '../sound.dart';
import '../../../service_locator.dart';
import '../sound_service.dart';

part 'sound_event.dart';
part 'sound_state.dart';

class SoundBloc extends Bloc<SoundEvent, SoundState> {
  final SoundService _soundService = getIt<SoundService>();

  SoundBloc() : super(SoundState.initial()) {
    on<SoundEventFetchBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final result = await _soundService.retriveBySku(event.sku);

        result.fold(
          (error) {
            emit(
              state.copyWith(
                errors: (state.errors.toBuilder()..[event.sku] = error).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },

          (sound) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = sound).build(),

                fetching: (state.fetching.toBuilder()..remove(event.sku))
                    .build(),
              ),
            );
          },
        );
      }
    });
  }
}
