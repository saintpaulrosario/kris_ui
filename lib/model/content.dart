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
  final Identifier language;
  final Identifier word;

  const Content({
    required this.payloads,
    required this.text,
    required this.script,
    required this.language,
    required this.word,
  }) : super(
         sku: '',
         version: 0,
         ordinal: 0,
         createdDate: null,
         lastModifiedDate: null,
         createdBy: '',
         lastModifiedBy: '',
       );

  factory Content.initial() {
    return Content(
      payloads: [],
      text: Identifier.initial(),
      script: Identifier.initial(),
      language: Identifier.initial(),
      word: Identifier.initial(),
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
