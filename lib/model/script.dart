import 'package:json_annotation/json_annotation.dart';

import 'content.dart';
import 'idenity.dart';

part 'script.g.dart';

@JsonSerializable(
  nullable: true,
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Script extends Identity {
  final List<Content>? contents;

  Script({required this.contents})
    : super(sku: '', version: 0, row: 0, ordinal: 0);

  factory Script.fromJson(Map<String, dynamic> json) => _$ScriptFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptToJson(this);
}
