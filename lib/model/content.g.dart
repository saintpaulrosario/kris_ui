// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map json) => $checkedCreate('Content', json, (
  $checkedConvert,
) {
  final val = Content(
    payload: $checkedConvert('payload', (v) => v as String? ?? ''),
    elements: $checkedConvert(
      'elements',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    words: $checkedConvert(
      'words',
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
    text: $checkedConvert(
      'text',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    rank: $checkedConvert('rank', (v) => (v as num?)?.toInt() ?? 0),
    script: $checkedConvert(
      'script',
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
    sku: $checkedConvert('sku', (v) => v as String? ?? ''),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? -1),
    row: $checkedConvert('row', (v) => (v as num?)?.toInt() ?? -1),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? -1),
    createdDate: $checkedConvert(
      'createdDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    lastModifiedDate: $checkedConvert(
      'lastModifiedDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    createdBy: $checkedConvert('createdBy', (v) => v as String?),
    lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
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
  );
  return val;
});

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'createdDate': instance.createdDate?.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
  'createdBy': instance.createdBy,
  'lastModifiedBy': instance.lastModifiedBy,
  'sku': instance.sku,
  'version': instance.version,
  'row': instance.row,
  'ordinal': instance.ordinal,
  'payload': instance.payload,
  'rank': instance.rank,
  'text': instance.text.toJson(),
  'script': instance.script?.toJson(),
  'dialects': instance.dialects.map((e) => e.toJson()).toList(),
  'languages': instance.languages.map((e) => e.toJson()).toList(),
  'elements': instance.elements.map((e) => e.toJson()).toList(),
  'words': instance.words.map((e) => e.toJson()).toList(),
  'sounds': instance.sounds.map((e) => e.toJson()).toList(),
  'examples': instance.examples.map((e) => e.toJson()).toList(),
};
