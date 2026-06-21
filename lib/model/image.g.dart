// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map json) =>
    $checkedCreate('Image', json, ($checkedConvert) {
      final val = Image(
        payload: $checkedConvert('payload', (v) => v as String? ?? ''),
        filename: $checkedConvert('filename', (v) => v as String? ?? ''),
        description: $checkedConvert('description', (v) => v as String? ?? ''),
        size: $checkedConvert('size', (v) => (v as num?)?.toInt() ?? 0),
        tags: $checkedConvert(
          'tags',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        ),
        words: $checkedConvert(
          'words',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) =>
                        Identity.fromJson(Map<String, dynamic>.from(e as Map)),
                  )
                  .toList() ??
              [],
        ),
        sounds: $checkedConvert(
          'sounds',
          (v) =>
              (v as List<dynamic>?)
                  ?.map(
                    (e) =>
                        Identity.fromJson(Map<String, dynamic>.from(e as Map)),
                  )
                  .toList() ??
              [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
  'payload': instance.payload,
  'filename': instance.filename,
  'description': instance.description,
  'size': instance.size,
  'tags': instance.tags,
  'words': instance.words.map((e) => e.toJson()).toList(),
  'sounds': instance.sounds.map((e) => e.toJson()).toList(),
};
