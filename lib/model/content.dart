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
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String? payload;

  //@JsonKey(disallowNullValue: false, defaultValue: '')
  final List<String>? types;

  //@JsonKey(disallowNullValue: false, defaultValue: '')
  final Identifier? word;

  //@JsonKey(disallowNullValue: false, defaultValue: )
  final Identifier? text;

  Content({
    required this.payload,
    required this.types,
    required this.word,
    required this.text,
  }) : super(sku: '', version: 0, row: 0, ordinal: 0);

  factory Content.initial() {
    return Content(
      payload: "",
      types: [],
      word: Identifier.initial(),
      text: Identifier.initial(),
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
