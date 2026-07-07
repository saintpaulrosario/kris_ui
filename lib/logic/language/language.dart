import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/identifier.dart';
import '../../model/word.dart';

part 'language.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Language extends Word {
  const Language({
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

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
