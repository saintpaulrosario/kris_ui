import 'package:json_annotation/json_annotation.dart';

import 'identifier.dart';
import 'instrument.dart';

part 'sound.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Sound extends Instrument {
  @JsonKey(defaultValue: [])
  final List<String> contents;

  @JsonKey(defaultValue: [])
  final List<Identifier> images;

  Sound({
    required this.contents,
    required this.images,
    required super.payload,
    required super.contentType,
    required super.size,
    required super.description,
    required super.tags,
    required super.sku,
    required super.version,
    required super.row,
    required super.ordinal,
  });

  factory Sound.initial() {
    return Sound(
      contents: [],
      images: [],
      payload: '',
      contentType: '',
      size: 0,
      description: '',
      tags: [],
      sku: '',
      version: -1,
      row: -1,
      ordinal: -1,
    );
  }

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SoundToJson(this);
}
