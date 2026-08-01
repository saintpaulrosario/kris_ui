import 'package:json_annotation/json_annotation.dart';

import 'content.dart';
import 'identifier.dart';

part 'translation_content.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class TranslationContent extends Content {
  @JsonKey(disallowNullValue: false)
  final Identifier text;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> payloads;
  TranslationContent({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.text,
    required this.payloads,
    required super.languages,
  });

  factory TranslationContent.initial() {
    return TranslationContent(
      sku: '',
      version: 0,
      ordinal: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      text: Identifier.initial(),
      payloads: [],
      languages: [],
    );
  }

  factory TranslationContent.fromJson(Map<String, dynamic> json) =>
      _$TranslationContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TranslationContentToJson(this);
}
