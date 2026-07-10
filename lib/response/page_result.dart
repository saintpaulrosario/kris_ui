import 'package:json_annotation/json_annotation.dart';

part 'page_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PageResult<T> {
  final List<T> content;
  final int totalElements;
  final int totalPages;
  final bool last;
  final bool first;
  final int size;
  final int number;

  const PageResult({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.first,
    required this.size,
    required this.number,
  });

  factory PageResult.initial() {
    return PageResult<T>(
      content: [],
      totalElements: 0,
      totalPages: 0,
      last: false,
      first: true,
      size: 0,
      number: 0,
    );
  }

  PageResult<T> copyWith({
    List<T>? content,
    int? totalElements,
    int? totalPages,
    bool? last,
    bool? first,
    int? size,
    int? number,
  }) {
    return PageResult<T>(
      content: content ?? this.content,
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      last: last ?? this.last,
      first: first ?? this.first,
      size: size ?? this.size,
      number: number ?? this.number,
    );
  }

  factory PageResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PageResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PageResultToJson(this, toJsonT);
}
