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
    version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? -1),
    row: $checkedConvert('row', (v) => (v as num?)?.toInt() ?? -1),
    ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? -1),
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
    roots: $checkedConvert(
      'roots',
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
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    lastModifiedDate: $checkedConvert(
      'lastModifiedDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    createdBy: $checkedConvert('createdBy', (v) => v as String?),
    lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
  'createdDate': instance.createdDate?.toIso8601String(),
  'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
  'createdBy': instance.createdBy,
  'lastModifiedBy': instance.lastModifiedBy,
  'sku': instance.sku,
  'version': instance.version,
  'row': instance.row,
  'ordinal': instance.ordinal,
  'texts': instance.texts.map((e) => e.toJson()).toList(),
  'contents': instance.contents.map((e) => e.toJson()).toList(),
  'images': instance.images.map((e) => e.toJson()).toList(),
  'roots': instance.roots.map((e) => e.toJson()).toList(),
};
