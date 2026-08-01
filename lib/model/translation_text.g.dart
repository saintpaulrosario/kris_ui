// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationText _$TranslationTextFromJson(Map json) => $checkedCreate(
  'TranslationText',
  json,
  ($checkedConvert) {
    final val = TranslationText(
      sku: $checkedConvert('sku', (v) => v as String? ?? ''),
      version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
      ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
      createdDate: $checkedConvert(
        'createdDate',
        (v) => DateTime.parse(v as String),
      ),
      lastModifiedDate: $checkedConvert(
        'lastModifiedDate',
        (v) => DateTime.parse(v as String),
      ),
      createdBy: $checkedConvert('createdBy', (v) => v as String?),
      lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
      word: $checkedConvert(
        'word',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      script: $checkedConvert(
        'script',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      contents: $checkedConvert(
        'contents',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$TranslationTextToJson(TranslationText instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy,
      'lastModifiedBy': instance.lastModifiedBy,
      'version': instance.version,
      'sku': instance.sku,
      'ordinal': instance.ordinal,
      'script': instance.script.toJson(),
      'word': instance.word.toJson(),
      'contents': instance.contents.map((e) => e.toJson()).toList(),
    };
