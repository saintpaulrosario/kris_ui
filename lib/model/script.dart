import 'package:json_annotation/json_annotation.dart';
import 'identifier.dart';
import 'word.dart';

part 'script.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Script extends Word {
  const Script({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.texts,
    required super.contents,
    required super.images,
    required super.payloads,
  });

  factory Script.fromJson(Map<String, dynamic> json) => _$ScriptFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScriptToJson(this);
}
