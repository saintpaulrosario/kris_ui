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

  Word({
    required super.sku,
    required super.version,
    required super.row,
    required super.ordinal,
    required this.texts,
    required this.contents,
    required this.images,
    required this.roots,
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
    );
  }

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
