// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map json) => $checkedCreate('Image', json, (
  $checkedConvert,
) {
  final val = Image(
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
  );
  return val;
});

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
  'words': instance.words.map((e) => e.toJson()).toList(),
  'sounds': instance.sounds.map((e) => e.toJson()).toList(),
};
