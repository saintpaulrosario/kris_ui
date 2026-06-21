import 'package:json_annotation/json_annotation.dart';

import 'content.dart';
import 'idenity.dart';
import 'word.dart';

part 'script.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Script extends Identity {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identity>? text;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Content>? contents;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<String>? types;

  Script({required this.text, required this.contents, required this.types})
    : super(sku: '', version: 0, row: 0, ordinal: 0);

  factory Script.fromJson(Map<String, dynamic> json) => _$ScriptFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScriptToJson(this);
}
