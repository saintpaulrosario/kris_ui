import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/word.dart';

import 'account.dart';
import 'identifier.dart';
import 'text.dart';

part 'language.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Language extends Word {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> scripts;
  const Language({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.texts,
    required this.scripts,
    //required this.examples,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.images,
  });

  factory Language.initial() {
    return Language(
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      scripts: [],
      images: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Language && other.sku == sku && other.ordinal == ordinal;
  }

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
