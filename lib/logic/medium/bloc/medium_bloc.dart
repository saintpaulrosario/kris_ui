import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kris/logic/medium/medium_state.dart';

import '../../../model/medium.dart';
import '../../../model/word_image.dart';
import '../../../response/error_response.dart';
import '../../../service_locator.dart';
import '../image_service.dart';

part 'medium_event.dart';

class MediumBloc extends Bloc<MediumEvent, MediumState> {
  final ImageService<WordImage> _imageService =
      getIt<ImageService<WordImage>>();

  MediumBloc() : super(MediumState.initial()) {
    on<MediumEventFetch>((event, emit) async {
      if (!state.data.containsKey(event.sku) &&
          !state.fetching.contains(event.sku)) {
        emit(
          state.copyWith(
            fetching: (state.fetching.toBuilder()..add(event.sku)).build(),
          ),
        );

        final Either<ErrorResponse, WordImage> result = await _imageService
            .retriveBySku(event.sku);

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

          (image) {
            emit(
              state.copyWith(
                data: (state.data.toBuilder()..[event.sku] = image).build(),

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
