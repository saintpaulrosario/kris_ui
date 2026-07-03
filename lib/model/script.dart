import 'package:json_annotation/json_annotation.dart';
import 'identifier.dart';

part 'script.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Script extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> text;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> elements;

  const Script({
    required this.text,
    required this.contents,
    required this.elements,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
  });

  factory Script.fromJson(Map<String, dynamic> json) => _$ScriptFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScriptToJson(this);
}
