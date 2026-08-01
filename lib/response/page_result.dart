import 'package:json_annotation/json_annotation.dart';

import '../model/page_metadata.dart';

part 'page_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PageResult<T> {
  final List<T> content;
  final PageMetadata page;

  const PageResult({required this.content, required this.page});

  factory PageResult.initial() {
    return PageResult<T>(content: const [], page: PageMetadata.initial());
  }

  PageResult<T> copyWith({List<T>? content, PageMetadata? page}) {
    return PageResult<T>(
      content: content ?? this.content,
      page: page ?? this.page,
    );
  }

  factory PageResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PageResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageResultToJson(this, toJsonT);
}
