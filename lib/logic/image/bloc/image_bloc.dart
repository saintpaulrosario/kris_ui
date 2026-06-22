import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../model/error_response.dart';
import '../../../model/image.dart';
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
      emit(state.copyWith(fetching: true, success: false));
      Either<ErrorResponse, Image> result = await _imageService.retrive(
        event.sku,
      );

      result.fold(
        (error) => emit(state.copyWith(fetching: false, success: false)),
        (success) => emit(
          state.copyWith(fetching: false, success: true, image: success),
        ),
      );
    });
  }
}
