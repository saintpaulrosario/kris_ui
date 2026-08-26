import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/medium.dart';

import 'account.dart';
import 'identifier.dart';

part 'sound.g.dart';

@JsonSerializable(
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Sound extends Medium {
  Sound({
    required super.content,
    required super.type,
    required super.size,
    required super.descriptions,
    required super.tags,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.checkSum,
    required super.rows,
  });

  factory Sound.initial() {
    return Sound(
      content: '',
      type: '',
      size: 0,
      descriptions: [],
      tags: [],
      sku: '',
      version: 0,
      ordinal: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      checkSum: '',
      rows: [],
    );
  }

  factory Sound.fromJson(Map<String, dynamic> json) => _$SoundFromJson(json);
}
