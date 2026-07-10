part of 'image_bloc.dart';

class ImageState extends BaseState<WordImage> {
  ImageState({
    required super.errors,
    required super.fetching,
    required super.data,
  });

  factory ImageState.initial() {
    return ImageState(errors: {}, fetching: {}, data: {});
  }

  @override
  ImageState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, WordImage>? data,
  }) {
    return ImageState(
      errors: errors ?? Map.from(this.errors),
      fetching: fetching ?? Set.from(this.fetching),
      data: data ?? Map.from(this.data),
    );
  }
}
