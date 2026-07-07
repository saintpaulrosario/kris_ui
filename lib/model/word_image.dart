import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'identifier.dart';
import 'instrument.dart';

part 'word_image.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class WordImage extends Instrument {
  @JsonKey(defaultValue: [])
  final List<Identifier> words;

  @JsonKey(defaultValue: [])
  final List<Identifier> sounds;

  const WordImage({
    required this.words,
    required this.sounds,
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

  factory WordImage.initial() {
    return WordImage(
      words: [],
      sounds: [],
      payload: '',
      contentType: '',
      size: 0,
      description: '',
      tags: [],
      sku: '',
      version: 0,
      ordinal: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
    );
  }

  factory WordImage.fromJson(Map<String, dynamic> json) =>
      _$WordImageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WordImageToJson(this);
}
