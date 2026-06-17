import 'package:json_annotation/json_annotation.dart';

import 'idenity.dart';

part 'content.g.dart';

@JsonSerializable(
  nullable: true,
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Content extends Identity {
  final String? payload;
  final String? type;
  final Identity? word;
  final Identity? text;

  Content({
    required this.payload,
    required this.type,
    required this.word,
    required this.text,
  }) : super(sku: '', version: 0, row: 0, ordinal: 0);

  factory Content.initial() {
    return Content(
      payload: "",
      type: "",
      word: Identity.initial(),
      text: Identity.initial(),
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
