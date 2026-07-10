part of 'image_bloc.dart';

class ImageState extends BaseState<WordImage> {
  ImageState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory ImageState.initial() {
    return ImageState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, WordImage>(),
      selections: BuiltSet<WordImage>(),
    );
  }

  @override
  ImageState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, WordImage>? data,
    BuiltSet<WordImage>? selections,
  }) {
    return ImageState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
