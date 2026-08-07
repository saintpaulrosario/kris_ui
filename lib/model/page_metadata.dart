import 'package:json_annotation/json_annotation.dart';

part 'page_metadata.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PageMetadata {
  final int size;
  final int number;
  final int totalElements;
  final int totalPages;

  const PageMetadata({
    required this.size,
    required this.number,
    required this.totalElements,
    required this.totalPages,
  });

  factory PageMetadata.initial() {
    return const PageMetadata(
      size: 0,
      number: 0,
      totalElements: 0,
      totalPages: 0,
    );
  }

  factory PageMetadata.fromJson(Map<String, dynamic> json) =>
      _$PageMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PageMetadataToJson(this);
}
