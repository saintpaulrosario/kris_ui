import 'package:json_annotation/json_annotation.dart';

import 'idenity.dart';

part 'image.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Image extends Identity {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String payload;

  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String filename;

  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String description;

  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final int size;

  @JsonKey(defaultValue: [])
  final List<String> tags;

  @JsonKey(defaultValue: [])
  final List<Identity> words;

  @JsonKey(defaultValue: [])
  final List<Identity> sounds;

  Image({
    required this.payload,
    required this.filename,
    required this.description,
    required this.size,
    required this.tags,
    required this.words,
    required this.sounds,
  }) : super(sku: '', version: 0, row: 0, ordinal: 0);

  factory Image.initial() {
    return Image(
      payload: "",
      filename: "",
      description: "",
      size: 0,
      tags: [],
      words: [],
      sounds: [],
    );
  }

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
