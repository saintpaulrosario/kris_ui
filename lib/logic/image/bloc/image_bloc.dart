import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fpdart/fpdart.dart';

import '../../error_response.dart';
import '../word_image.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../image_service.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageService _imageService = getIt<ImageService>();

  ImageBloc() : super(ImageState.initial()) {
    on<RetrieveImagesBySkuEvent>((event, emit) async {
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
