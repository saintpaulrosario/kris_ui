import 'package:json_annotation/json_annotation.dart';

import 'account.dart';
import 'identifier.dart';

part 'payload.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Payload extends Identifier {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String value;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> dialects;

  @JsonKey(disallowNullValue: false)
  final Identifier? language;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> audios;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> traits;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> types;

  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<int> rows;

  const Payload({
    required super.sku,
    required super.version,
    required super.ordinal,
    required this.value,
    required this.dialects,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required this.audios,
    required this.traits,
    required this.rows,
    required this.language,
    required this.types,
  });

  factory Payload.initial() {
    return Payload(
      sku: '',
      version: 0,
      ordinal: -1,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      value: '',
      dialects: [],
      audios: [],
      traits: [],
      rows: [],
      language: Identifier.initial(),
      types: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payload && other.sku == sku && other.ordinal == ordinal;
  }

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}
