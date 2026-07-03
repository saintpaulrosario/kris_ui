import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

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

  const Sound({
    required this.contents,
    required this.images,
    required super.payload,
    required super.contentType,
    required super.size,
    required super.description,
    required super.tags,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
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
      version: 0,
      ordinal: 0,
      createdDate: null,
      lastModifiedDate: null,
      createdBy: '',
      lastModifiedBy: '',
    );
  }

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SoundToJson(this);
}
