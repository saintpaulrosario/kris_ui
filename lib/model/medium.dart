import 'package:json_annotation/json_annotation.dart';

import 'account.dart';
import 'identifier.dart';

part 'medium.g.dart';

@JsonSerializable(
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Medium extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String content;

  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String type;

  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String checkSum;

  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final num size;

  @JsonKey(disallowNullValue: false, defaultValue: <Identifier>[])
  final List<Identifier> descriptions;

  @JsonKey(disallowNullValue: false, defaultValue: <Identifier>[])
  final List<Identifier> tags;

  const Medium({
    required this.content,
    required this.type,
    required this.size,
    required this.descriptions,
    required this.tags,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.checkSum,
  });

  factory Medium.initial() {
    return Medium(
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
    );
  }

  factory Medium.fromJson(Map<String, dynamic> json) => _$MediumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediumToJson(this);
}
