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

  const Audit({
    required this.createdDate,
    required this.lastModifiedDate,
    required this.createdBy,
    required this.lastModifiedBy,
  });

  factory Audit.initial() {
    return Audit(
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: null,
      lastModifiedBy: null,
    );
  }

  factory Audit.fromJson(Map<String, dynamic> json) => _$AuditFromJson(json);

  Map<String, dynamic> toJson() => _$AuditToJson(this);
}
