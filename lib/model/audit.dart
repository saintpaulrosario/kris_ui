import 'package:json_annotation/json_annotation.dart';

part 'audit.g.dart';

@JsonSerializable(
  includeIfNull: false,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Audit {
  final DateTime createdDate;
  final DateTime lastModifiedDate;
  final String? createdBy;
  final String? lastModifiedBy;
  @JsonKey(disallowNullValue: false, defaultValue: 0)
  final int version;

  const Audit({
    required this.createdDate,
    required this.lastModifiedDate,
    required this.createdBy,
    required this.lastModifiedBy,
    required this.version,
  });

  factory Audit.initial() {
    return Audit(
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: null,
      lastModifiedBy: null,
      version: 0,
    );
  }

  factory Audit.fromJson(Map<String, dynamic> json) => _$AuditFromJson(json);

  Map<String, dynamic> toJson() => _$AuditToJson(this);
}
