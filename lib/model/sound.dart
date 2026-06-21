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

  Sound({required this.contents, required this.images})
    : super(payload: '', contentType: '', size: 0, description: '', tags: []);

  factory Sound.initial() {
    return Sound(contents: [], images: []);
  }

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SoundToJson(this);
}
