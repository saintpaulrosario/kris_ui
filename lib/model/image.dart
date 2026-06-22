import 'package:json_annotation/json_annotation.dart';

import 'identifier.dart';
import 'instrument.dart';

part 'image.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Image extends Instrument {
  @JsonKey(defaultValue: [])
  final List<Identifier> words;

  @JsonKey(defaultValue: [])
  final List<Identifier> sounds;

  Image({
    required this.words,
    required this.sounds,
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

  factory Image.initial() {
    return Image(
      words: [],
      sounds: [],
      payload: '',
      contentType: '',
      size: 0,
      description: '',
      tags: [],
      sku: '',
      version: 0,
      row: 0,
      ordinal: 0,
    );
  }

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
