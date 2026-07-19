// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map json) => $checkedCreate('Word', json, (
  $checkedConvert,
) {
  final val = Word(
    sku: $checkedConvert('sku', (v) => v as String? ?? ''),
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
    type: $checkedConvert('type', (v) => v as String? ?? ''),
    texts: $checkedConvert(
      'texts',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    contents: $checkedConvert(
      'contents',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    images: $checkedConvert(
      'images',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    payloads: $checkedConvert(
      'payloads',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
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
    maya: $checkedConvert(
      'maya',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    ),
    examples: $checkedConvert(
      'examples',
      (v) => (v as List<dynamic>)
          .map((e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
  'createdDate': instance.createdDate.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
  'createdBy': instance.createdBy,
  'lastModifiedBy': instance.lastModifiedBy,
  'sku': instance.sku,
  'version': instance.version,
  'ordinal': instance.ordinal,
  'type': instance.type,
  'texts': instance.texts.map((e) => e.toJson()).toList(),
  'contents': instance.contents.map((e) => e.toJson()).toList(),
  'images': instance.images.map((e) => e.toJson()).toList(),
  'payloads': instance.payloads.map((e) => e.toJson()).toList(),
  'examples': instance.examples.map((e) => e.toJson()).toList(),
  'maya': instance.maya,
};
