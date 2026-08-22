import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/word.dart';

import 'account.dart';
import 'identifier.dart';

part 'script.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Script extends Word {
  @JsonKey(disallowNullValue: false, defaultValue: [])
  final List<Identifier> languages;
  const Script({
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.texts,
    required this.languages,
    //required this.examples,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy
  });

  factory Script.initial() {
    return Script(
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
      languages: [],
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Script && other.sku == sku && other.ordinal == ordinal;
  }

  factory Script.fromJson(Map<String, dynamic> json) => _$ScriptFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScriptToJson(this);
}
