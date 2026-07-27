import 'package:json_annotation/json_annotation.dart';

import '../identifier.dart';

part 'word_text.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class WordText extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> words;

  @JsonKey(disallowNullValue: false)
  final Identifier? script;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> languages;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> dialects;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> elements;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  const WordText({
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.dialects,
    required this.contents,
    required this.languages,
    required this.words,
    required this.script,
    required this.elements,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.type,
  });

  factory WordText.initial() {
    return WordText(
      sku: '',
      version: 0,
      ordinal: 0,
      dialects: [],
      contents: [],
      languages: [],
      words: [],
      script: Identifier.initial(),
      elements: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      type: '',
    );
  }

  factory WordText.fromJson(Map<String, dynamic> json) =>
      _$WordTextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordTextToJson(this);
}
