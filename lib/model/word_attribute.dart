import 'package:json_annotation/json_annotation.dart';

import 'identifier.dart';

part 'word_attribute.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class WordAttribute {
  @JsonKey(disallowNullValue: false)
  final Identifier text;
  final Identifier script;
  final Identifier dialect;
  final Identifier language;
  final Identifier trait;
  final List<Identifier> sounds;

  const WordAttribute({
    required this.text,
    required this.script,
    required this.dialect,
    required this.language,
    required this.trait,
    required this.sounds,
  });

  factory WordAttribute.initial() {
    return WordAttribute(
      text: Identifier.initial(),
      script: Identifier.initial(),
      dialect: Identifier.initial(),
      language: Identifier.initial(),
      trait: Identifier.initial(),
      sounds: [],
    );
  }

  // @override
  // int get hashCode => Object.hash(word.sku, word.sku);

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is WordAttribute && other.word.sku == word.sku;
  // }

  factory WordAttribute.fromJson(Map<String, dynamic> json) =>
      _$WordAttributeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordAttributeToJson(this);
}
