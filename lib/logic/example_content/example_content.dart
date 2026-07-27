import 'package:json_annotation/json_annotation.dart';
import 'package:kris/logic/content/content.dart';

import '../identifier.dart';

part 'example_content.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class ExampleContent extends Content {
  ExampleContent({
    required super.payloads,
    required super.text,
    required super.script,
    required super.language,
    required super.word,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.type,
  });

  factory ExampleContent.initial() {
    return ExampleContent(
      payloads: [],
      text: Identifier.initial(),
      script: Identifier.initial(),
      language: Identifier.initial(),
      word: Identifier.initial(),
      sku: '',
      version: 0,
      ordinal: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      type: '',
    );
  }

  factory ExampleContent.fromJson(Map<String, dynamic> json) =>
      _$ExampleContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ExampleContentToJson(this);
}
