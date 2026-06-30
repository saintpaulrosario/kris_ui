import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'identifier.dart';

part 'content.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Content extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String payload;

  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final int rank;

  @JsonKey(disallowNullValue: false)
  final Identifier word;

  @JsonKey(disallowNullValue: false)
  final Identifier? script;

  @JsonKey(disallowNullValue: false)
  final Identifier text;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> elements;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> scripts;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> languages;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> sounds;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> examples;

  Content({
    required this.payload,
    required this.elements,
    required this.word,
    required this.scripts,
    required this.languages,
    required this.sounds,
    required this.text,
    required this.rank,
    required this.script,
    required this.examples,
    required super.sku,
    required super.version,
    required super.row,
    required super.ordinal,
  });

  factory Content.initial() {
    return Content(
      payload: "",
      elements: [],
      word: Identifier.initial(),
      text: Identifier.initial(),
      scripts: [],
      languages: [],
      sounds: [],
      examples: [],
      script: Identifier.initial(),
      rank: 0,
      sku: '',
      version: 0,
      row: 0,
      ordinal: 0,
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
