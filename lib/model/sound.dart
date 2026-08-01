import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'identifier.dart';
import 'instrument.dart';

part 'sound.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  disallowUnrecognizedKeys: true,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Sound extends Instrument {
  const Sound({
    // required this.payloads,
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
      // payloads: [],
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

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SoundToJson(this);
}
