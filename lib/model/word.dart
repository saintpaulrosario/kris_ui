import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'identifier.dart';

part 'word.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Word extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> texts;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> images;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> roots;

  const Word({
    required super.sku,
    required super.version,
    required super.row,
    required super.ordinal,
    required this.texts,
    required this.contents,
    required this.images,
    required this.roots,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
  });

  factory Word.initial() {
    return Word(
      sku: '',
      version: 0,
      row: 0,
      ordinal: -1,
      texts: [],
      contents: [],
      images: [],
      roots: [],
      createdDate: null,
      lastModifiedDate: null,
      createdBy: '',
      lastModifiedBy: '',
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Word && other.sku == sku && other.ordinal == ordinal;
  }

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
