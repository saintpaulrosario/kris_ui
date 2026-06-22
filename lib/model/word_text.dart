import 'package:json_annotation/json_annotation.dart';

import 'identifier.dart';

part 'word_text.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class WordText extends Identifier {
  final Identifier word;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> scripts;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> languages;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> dialects;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> types;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  WordText({
    required super.sku,
    required super.version,
    required super.row,
    required super.ordinal,
    required this.dialects,
    required this.contents,
    required this.languages,
    required this.word,
    required this.scripts,
    required this.types,
  });

  factory WordText.initial() {
    return WordText(
      sku: '',
      version: 0,
      row: 0,
      ordinal: 0,
      dialects: [],
      contents: [],
      languages: [],
      word: Identifier.initial(),
      scripts: [],
      types: [],
    );
  }

  factory WordText.fromJson(Map<String, dynamic> json) =>
      _$WordTextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordTextToJson(this);
}
