import 'package:json_annotation/json_annotation.dart';

import 'identifier.dart';
import 'payload.dart';

part 'translation_payload.g.dart';

@JsonSerializable(
   genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class TranslationPayload extends Payload {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> contents;

  const TranslationPayload({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.contents,
    required super.value,
    required super.dialects,
    required super.sounds,
  });

  factory TranslationPayload.initial() {
    return TranslationPayload(
      sku: '',
      version: 0,
      ordinal: -1,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      contents: [],
      value: '',
      dialects: [],
      sounds: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranslationPayload &&
        other.sku == sku &&
        other.ordinal == ordinal;
  }

  factory TranslationPayload.fromJson(Map<String, dynamic> json) =>
      _$TranslationPayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TranslationPayloadToJson(this);
}
