import 'package:json_annotation/json_annotation.dart';

import 'idenity.dart';

part 'content.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Content extends Identity {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String? payload;

  //@JsonKey(disallowNullValue: false, defaultValue: '')
  final List<String>? types;

  //@JsonKey(disallowNullValue: false, defaultValue: '')
  final Identity? word;

  //@JsonKey(disallowNullValue: false, defaultValue: )
  final Identity? text;

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
      word: Identity.initial(),
      text: Identity.initial(),
    );
  }

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
