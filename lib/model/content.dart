import 'package:json_annotation/json_annotation.dart';

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
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> payloads;
  final Identifier text;
  final Identifier script;
  @JsonKey(disallowNullValue: false)
  final Identifier? language;
  final Identifier word;

  const Content({
    required this.payloads,
    required this.text,
    required this.script,
    required this.language,
    required this.word,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
  });

  factory Content.initial() {
    return Content(
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
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
