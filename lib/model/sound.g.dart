// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sound _$SoundFromJson(Map json) => $checkedCreate('Sound', json, (
  $checkedConvert,
) {
  final val = Sound(
    contents: $checkedConvert(
      'contents',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
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
  );
  return val;
});

Map<String, dynamic> _$SoundToJson(Sound instance) => <String, dynamic>{
  'contents': instance.contents,
  'images': instance.images.map((e) => e.toJson()).toList(),
};
