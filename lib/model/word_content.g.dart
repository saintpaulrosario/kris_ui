// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordContent _$WordContentFromJson(Map json) => $checkedCreate(
  'WordContent',
  json,
  ($checkedConvert) {
    final val = WordContent(
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
      text: $checkedConvert(
        'text',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      payloads: $checkedConvert(
        'payloads',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      languages: $checkedConvert(
        'languages',
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

Map<String, dynamic> _$WordContentToJson(WordContent instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy,
      'lastModifiedBy': instance.lastModifiedBy,
      'version': instance.version,
      'sku': instance.sku,
      'ordinal': instance.ordinal,
      'languages': instance.languages.map((e) => e.toJson()).toList(),
      'text': instance.text.toJson(),
      'payloads': instance.payloads.map((e) => e.toJson()).toList(),
    };
