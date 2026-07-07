import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/identifier.dart';
import '../../model/word.dart';

part 'dialect.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Dialect extends Word {
  const Dialect({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.texts,
    required super.contents,
    required super.images,
    required super.roots,
  });

  factory Dialect.fromJson(Map<String, dynamic> json) =>
      _$DialectFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DialectToJson(this);
}
