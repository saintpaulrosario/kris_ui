part of 'image_bloc.dart';

class ImageState extends BaseState {
  final Map<String, WordImage> images;

  ImageState({required this.images}) : super(errors: {}, fetching: {});

  factory ImageState.initial() {
    return ImageState(images: {});
  }

  @override
  ImageState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, WordImage>? images,
  }) {
    return ImageState(images: images ?? this.images);
  }
}
