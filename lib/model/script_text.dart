import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/text.dart';

import 'identifier.dart';

part 'script_text.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class ScriptText extends Text {
  @JsonKey(disallowNullValue: false)
  final Identifier translation;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  const ScriptText({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.translation,
    required super.script,
    required this.contents,
  });

  factory ScriptText.initial() {
    return ScriptText(
      sku: '',
      version: 0,
      ordinal: 0,
      contents: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      script: Identifier.initial(),
      translation: Identifier.initial(),
      //word: Identifier.initial(),
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScriptText && other.sku == sku && other.ordinal == ordinal;
  }

  factory ScriptText.fromJson(Map<String, dynamic> json) =>
      _$ScriptTextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScriptTextToJson(this);
}
