// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleText _$ExampleTextFromJson(Map json) => $checkedCreate(
  'ExampleText',
  json,
  ($checkedConvert) {
    final val = ExampleText(
      sku: $checkedConvert('sku', (v) => v as String? ?? ''),
      version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
      ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
      dialects: $checkedConvert(
        'dialects',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
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
      words: $checkedConvert(
        'words',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      script: $checkedConvert(
        'script',
        (v) => v == null
            ? null
            : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      elements: $checkedConvert(
        'elements',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
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
      type: $checkedConvert('type', (v) => v as String? ?? ''),
      text: $checkedConvert('text', (v) => v as String? ?? ''),
    );
    return val;
  },
);

Map<String, dynamic> _$ExampleTextToJson(ExampleText instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy,
      'lastModifiedBy': instance.lastModifiedBy,
      'sku': instance.sku,
      'version': instance.version,
      'ordinal': instance.ordinal,
      'type': instance.type,
      'words': instance.words.map((e) => e.toJson()).toList(),
      'script': instance.script?.toJson(),
      'languages': instance.languages.map((e) => e.toJson()).toList(),
      'dialects': instance.dialects.map((e) => e.toJson()).toList(),
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'contents': instance.contents.map((e) => e.toJson()).toList(),
      'text': instance.text,
    };
