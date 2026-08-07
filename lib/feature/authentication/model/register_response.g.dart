// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      email: json['email'] as String,
      sku: json['sku'] as String,
      locked: json['locked'] as bool,
      enabled: json['enabled'] as bool,
      accountNonExpired: json['accountNonExpired'] as bool,
      credentialsNonExpired: json['credentialsNonExpired'] as bool,
      accountNonLocked: json['accountNonLocked'] as bool,
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'sku': instance.sku,
      'email': instance.email,
      'locked': instance.locked,
      'enabled': instance.enabled,
      'accountNonExpired': instance.accountNonExpired,
      'credentialsNonExpired': instance.credentialsNonExpired,
      'accountNonLocked': instance.accountNonLocked,
    };
