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
    types: $checkedConvert(
      'types',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList() ??
          [],
    ),
    word: $checkedConvert(
      'word',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    scripts: $checkedConvert(
      'scripts',
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
  );
  return val;
});

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'payload': instance.payload,
  'rank': instance.rank,
  'word': instance.word.toJson(),
  'script': instance.script?.toJson(),
  'text': instance.text.toJson(),
  'types': instance.types.map((e) => e.toJson()).toList(),
  'scripts': instance.scripts.map((e) => e.toJson()).toList(),
  'languages': instance.languages.map((e) => e.toJson()).toList(),
  'sounds': instance.sounds.map((e) => e.toJson()).toList(),
  'examples': instance.examples.map((e) => e.toJson()).toList(),
};
