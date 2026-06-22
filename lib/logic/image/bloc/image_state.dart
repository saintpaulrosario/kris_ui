part of 'image_bloc.dart';

class ImageState extends BaseState {
  final Image image;

  ImageState({required this.image})
    : super(
        fetching: false,
        success: false,
        message: '',
        error: ErrorResponse.initial(),
        failure: false,
      );

  factory ImageState.initial() {
    return ImageState(image: Image.initial());
  }

  @override
  ImageState copyWith({
    ErrorResponse? error,
    bool? success,
    bool? failure,
    String? message,
    int? code,
    bool? fetching,
    Image? image,
  }) {
    return ImageState(image: image ?? this.image);
  }
}
