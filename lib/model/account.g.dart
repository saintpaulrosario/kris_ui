// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map json) =>
    $checkedCreate('Account', json, ($checkedConvert) {
      final val = Account(sku: $checkedConvert('sku', (v) => v as String));
      return val;
    });

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'sku': instance.sku,
};
