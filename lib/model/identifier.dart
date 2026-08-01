import 'package:json_annotation/json_annotation.dart';

import 'audit.dart';

part 'identifier.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Identifier extends Audit {
  @JsonKey(disallowNullValue: false, defaultValue: '')
  final String sku;

  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final int ordinal;

  const Identifier({
    required this.sku,
    required this.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.version,
  });

  factory Identifier.initial() {
    return Identifier(
      sku: '',
      ordinal: -1,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      version: 0,
    );
  }

  factory Identifier.fromJson(Map<String, dynamic> json) {
    return _$IdentifierFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$IdentifierToJson(this);
}
