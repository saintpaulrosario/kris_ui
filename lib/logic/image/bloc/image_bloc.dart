import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/error_response.dart';
import '../../../model/word_image.dart';
import '../../../service_locator.dart';
import '../../base_state.dart';
import '../image_service.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageService _imageService = getIt<ImageService>();

  ImageBloc() : super(ImageState.initial()) {
    on<ImageEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<RetrieveImagesBySkuEvent>((event, emit) async {
      final fetching = Set<String>.from(state.fetching);
      fetching.add(event.sku);
      emit(state.copyWith(fetching: fetching));

      Either<ErrorResponse, WordImage> result = await _imageService
          .retriveBySku(event.sku);
      fetching.remove(event.sku);
      emit(state.copyWith(fetching: fetching));

      result.fold((error) {}, (image) {
        final images = Map<String, WordImage>.from(state.data);
        images[event.sku] = image;
        emit(state.copyWith(data: images));
      });
    });
  }
}
