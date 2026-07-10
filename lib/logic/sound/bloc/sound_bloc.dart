import 'package:bloc/bloc.dart';
import 'package:kris/logic/base_state.dart';

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

    on<SoundEventFetchBySku>((event, emit) async {
      if (!state.data.containsKey(event.sku)) {
        final fetching = Set<String>.from(state.fetching);
        fetching.add(event.sku);
        emit(state.copyWith(fetching: fetching));

        final results = await _soundService.retriveBySku(event.sku);

        fetching.remove(event.sku);

        results.fold(
          (error) {
            fetching.remove(event.sku);
            emit(state.copyWith(fetching: fetching));
          },
          (result) {
            final data = Map<String, Sound>.from(state.data);
            data[event.sku] = result;
            emit(state.copyWith(fetching: fetching, data: data));
          },
        );
      }
    });
  }
}
