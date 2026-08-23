// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      principal: json['principal'] as String,
      secret: json['secret'] as String,
      phone: (json['phone'] as num).toInt(),
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'principal': instance.principal,
      'secret': instance.secret,
      'phone': instance.phone,
    };
