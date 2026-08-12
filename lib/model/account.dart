import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  includeIfNull: true,
  ignoreUnannotated: false,
  explicitToJson: true,
  anyMap: true,
  checked: true,
)
class Account {
  @JsonKey(disallowNullValue: false)
  final String sku;

  Account({required this.sku});

  factory Account.initial() {
    return Account(sku: '');
  }

  @override
  int get hashCode => Object.hash(sku, sku);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account && other.sku == sku;
  }

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
