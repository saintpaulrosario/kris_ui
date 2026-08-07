import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final String sku;
  final String email;
  final bool locked;
  final bool enabled;
  final bool accountNonExpired;
  final bool credentialsNonExpired;
  final bool accountNonLocked;

  RegisterResponse({
    required this.email,
    required this.sku,
    required this.locked,
    required this.enabled,
    required this.accountNonExpired,
    required this.credentialsNonExpired,
    required this.accountNonLocked,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
