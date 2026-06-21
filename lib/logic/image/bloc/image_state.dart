part of 'image_bloc.dart';

class ImageState extends BaseState {
  final List<Image> images;
  final Image selection;

  ImageState({required this.images, required this.selection})
    : super(
        fetching: false,
        success: false,
        message: '',
        error: ErrorResponse.initial(),
      );

  factory ImageState.initial() {
    return ImageState(images: [], selection: Image.initial());
  }

  @override
  ImageState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    List<Image>? images,
    Image? selection,
  }) {
    return ImageState(
      images: images ?? this.images,
      selection: selection ?? this.selection,
    );
  }
}
