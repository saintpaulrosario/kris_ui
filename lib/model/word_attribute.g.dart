// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordAttribute _$WordAttributeFromJson(Map json) => $checkedCreate(
  'WordAttribute',
  json,
  ($checkedConvert) {
    final val = WordAttribute(
      text: $checkedConvert(
        'text',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      script: $checkedConvert(
        'script',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      dialect: $checkedConvert(
        'dialect',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      language: $checkedConvert(
        'language',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      trait: $checkedConvert(
        'trait',
        (v) => Identifier.fromJson(Map<String, dynamic>.from(v as Map)),
      ),
      sounds: $checkedConvert(
        'sounds',
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

Map<String, dynamic> _$WordAttributeToJson(WordAttribute instance) =>
    <String, dynamic>{
      'text': instance.text.toJson(),
      'script': instance.script.toJson(),
      'dialect': instance.dialect.toJson(),
      'language': instance.language.toJson(),
      'trait': instance.trait.toJson(),
      'sounds': instance.sounds.map((e) => e.toJson()).toList(),
    };
