import 'package:json_annotation/json_annotation.dart';
import 'package:kris/model/account.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/word.dart';

part 'type.g.dart';

@JsonSerializable(
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Type extends Word {
  @JsonKey(disallowNullValue: false, defaultValue: const [])
  final List<Identifier> subTypes;

  @JsonKey(disallowNullValue: false, defaultValue: const [])
  final List<Identifier> payloads;

  @JsonKey(disallowNullValue: false, defaultValue: const [])
  final List<Identifier> words;

  const Type({
    required this.subTypes,
    required super.sku,
    required super.version,
    required super.ordinal,
    required super.texts,
    required super.createdDate,
    required super.lastModifiedDate,
    required super.createdBy,
    required super.lastModifiedBy,
    required super.rows,
    required this.payloads,
    required this.words,
  });

  factory Type.initial() {
    return Type(
      sku: '',
      version: 0,
      ordinal: 0,
      texts: [],
      rows: [],
      subTypes: [],
      payloads: [],
      words: [],
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: Account.initial(),
      lastModifiedBy: Account.initial(),
    );
  }

  @override
  int get hashCode => Object.hash(sku, ordinal);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Type && other.sku == sku && other.ordinal == ordinal;
  }

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
