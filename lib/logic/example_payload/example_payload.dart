import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/payload.dart';

import '../../model/identifier.dart';

part 'example_payload.g.dart';

@JsonSerializable(
  disallowUnrecognizedKeys: false,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class ExamplePayload extends Payload {
  ExamplePayload({
    required super.row,
    required super.value,
    required super.script,
    required super.text,
    required super.content,
    required super.word,
    required super.sounds,
    required super.language,
    required super.dialect,
    required super.root,
    required super.examples,
  });

  factory ExamplePayload.initial() {
    return ExamplePayload(
      row: 0,
      value: '',
      script: Identifier.initial(),
      text: Identifier.initial(),
      content: Identifier.initial(),
      word: Identifier.initial(),
      sounds: [],
      language: Identifier.initial(),
      dialect: Identifier.initial(),
      root: Identifier.initial(),
      examples: [],
    );
  }

  factory ExamplePayload.fromJson(Map<String, dynamic> json) =>
      _$ExamplePayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExamplePayloadToJson(this);
}
