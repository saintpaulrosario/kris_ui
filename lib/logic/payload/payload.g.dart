// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map json) => $checkedCreate('Payload', json, (
  $checkedConvert,
) {
  final val = Payload(
    rank: $checkedConvert('rank', (v) => (v as num?)?.toInt() ?? 1),
    value: $checkedConvert('value', (v) => v as String? ?? ''),
    script: $checkedConvert(
      'script',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    text: $checkedConvert(
      'text',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    content: $checkedConvert(
      'content',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    word: $checkedConvert(
      'word',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    sounds: $checkedConvert(
      'sounds',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    languages: $checkedConvert(
      'languages',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    dialects: $checkedConvert(
      'dialects',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    root: $checkedConvert(
      'root',
      (v) => v == null
          ? null
          : Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    examples: $checkedConvert(
      'examples',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
    sku: $checkedConvert('sku', (v) => v as String? ?? ''),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
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
  );
  return val;
});

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy,
  'lastModifiedBy': instance.lastModifiedBy,
  'sku': instance.sku,
  'version': instance.version,
  'ordinal': instance.ordinal,
  'type': instance.type,
  'rank': instance.rank,
  'value': instance.value,
  'script': instance.script.toJson(),
  'languages': instance.languages.map((e) => e.toJson()).toList(),
  'dialects': instance.dialects.map((e) => e.toJson()).toList(),
  'text': instance.text.toJson(),
  'content': instance.content.toJson(),
  'word': instance.word.toJson(),
  'root': instance.root?.toJson(),
  'examples': instance.examples.map((e) => e.toJson()).toList(),
  'sounds': instance.sounds.map((e) => e.toJson()).toList(),
};
