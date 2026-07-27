import 'package:json_annotation/json_annotation.dart';
import 'package:kris/logic/payload/payload.dart';

import '../identifier.dart';

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
    required super.value,
    required super.script,
    required super.text,
    required super.content,
    required super.word,
    required super.sounds,
    required super.languages,
    required super.dialects,
    required super.root,
    required super.examples,
    required super.ordinal,
    required super.sku,
    required super.version,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.type,
    required super.rank,
  });

  factory ExamplePayload.initial() {
    return ExamplePayload(
      rank: 0,
      value: '',
      script: Identifier.initial(),
      text: Identifier.initial(),
      content: Identifier.initial(),
      word: Identifier.initial(),
      sounds: [],
      languages: [],
      dialects: [],
      root: Identifier.initial(),
      examples: [],
      ordinal: 0,
      sku: '',
      version: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      type: '',
    );
  }

  factory ExamplePayload.fromJson(Map<String, dynamic> json) =>
      _$ExamplePayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExamplePayloadToJson(this);
}
