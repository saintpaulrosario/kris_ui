import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

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
  final int version;

  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final int ordinal;

  const Identifier({
    required this.sku,
    required this.version,
    required this.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
  });

  factory Identifier.initial() {
    return Identifier(
      sku: '',
      version: 0,
      ordinal: -1,
      createdDate: null,
      lastModifiedDate: null,
      createdBy: '',
      lastModifiedBy: '',
    );
  }

  factory Identifier.fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return Identifier.initial();
    }
    return _$IdentifierFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$IdentifierToJson(this);
}
