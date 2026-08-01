import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/text.dart';

import 'identifier.dart';

part 'word_text.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class WordText extends Text {
  @JsonKey(disallowNullValue: false)
  final Identifier word;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  const WordText({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.word,
    required super.script,
    required this.contents,
  });

  factory WordText.initial() {
    return WordText(
      sku: '',
      version: 0,
      ordinal: 0,
      contents: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      script: Identifier.initial(),
      word: Identifier.initial(),
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WordText && other.sku == sku && other.ordinal == ordinal;
  }

  factory WordText.fromJson(Map<String, dynamic> json) =>
      _$WordTextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordTextToJson(this);
}
