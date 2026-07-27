import 'package:json_annotation/json_annotation.dart';
import 'package:kris/logic/identifier.dart';
import 'package:kris/logic/text/word_text.dart';

part 'example_text.g.dart';

@JsonSerializable(
  disallowUnrecognizedKeys: false,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class ExampleText extends WordText {
  ExampleText({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.dialects,
    required super.contents,
    required super.languages,
    required super.words,
    required super.script,
    required super.elements,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.type,
  });

  factory ExampleText.initial() {
    return ExampleText(
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

  factory ExampleText.fromJson(Map<String, dynamic> json) =>
      _$ExampleTextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExampleTextToJson(this);
}
