// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map json) => $checkedCreate('Payload', json, (
  $checkedConvert,
) {
  final val = Payload(
    row: $checkedConvert('row', (v) => (v as num).toInt()),
    value: $checkedConvert('value', (v) => v as String),
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
    language: $checkedConvert(
      'language',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    word: $checkedConvert(
      'word',
      (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
    ),
    sounds: $checkedConvert(
      'sounds',
      (v) => (v as List<dynamic>)
          .map((e) => Identifier.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
  'row': instance.row,
  'value': instance.value,
  'script': instance.script.toJson(),
  'text': instance.text.toJson(),
  'content': instance.content.toJson(),
  'language': instance.language.toJson(),
  'word': instance.word.toJson(),
  'sounds': instance.sounds.map((e) => e.toJson()).toList(),
};
