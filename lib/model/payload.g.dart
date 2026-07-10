// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map json) => $checkedCreate('Payload', json, (
  $checkedConvert,
) {
  final val = Payload(
    row: $checkedConvert('row', (v) => (v as num?)?.toInt() ?? -1),
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
    language: $checkedConvert(
      'language',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    dialect: $checkedConvert(
      'dialect',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
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
  );
  return val;
});

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
  'row': instance.row,
  'value': instance.value,
  'script': instance.script.toJson(),
  'language': instance.language.toJson(),
  'dialect': instance.dialect.toJson(),
  'text': instance.text.toJson(),
  'content': instance.content.toJson(),
  'word': instance.word.toJson(),
  'root': instance.root?.toJson(),
  'examples': instance.examples.map((e) => e.toJson()).toList(),
  'sounds': instance.sounds.map((e) => e.toJson()).toList(),
};
