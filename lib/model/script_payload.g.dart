// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScriptPayload _$ScriptPayloadFromJson(Map json) => $checkedCreate(
  'ScriptPayload',
  json,
  ($checkedConvert) {
    final val = ScriptPayload(
      sku: $checkedConvert('sku', (v) => v as String? ?? ''),
      version: $checkedConvert('version', (v) => (v as num?)?.toInt() ?? 0),
      ordinal: $checkedConvert('ordinal', (v) => (v as num?)?.toInt() ?? 0),
      createdDate: $checkedConvert(
        'createdDate',
        (v) => DateTime.parse(v as String),
      ),
      lastModifiedDate: $checkedConvert(
        'lastModifiedDate',
        (v) => DateTime.parse(v as String),
      ),
      createdBy: $checkedConvert('createdBy', (v) => v as String?),
      lastModifiedBy: $checkedConvert('lastModifiedBy', (v) => v as String?),
      contents: $checkedConvert(
        'contents',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      value: $checkedConvert('value', (v) => v as String? ?? ''),
      dialects: $checkedConvert(
        'dialects',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
      sounds: $checkedConvert(
        'sounds',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      Identifier.fromJson(Map<String, dynamic>.from(e as Map)),
                )
                .toList() ??
            [],
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$ScriptPayloadToJson(ScriptPayload instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate.toIso8601String(),
      'createdBy': instance.createdBy,
      'lastModifiedBy': instance.lastModifiedBy,
      'version': instance.version,
      'sku': instance.sku,
      'ordinal': instance.ordinal,
      'value': instance.value,
      'dialects': instance.dialects.map((e) => e.toJson()).toList(),
      'sounds': instance.sounds.map((e) => e.toJson()).toList(),
      'contents': instance.contents.map((e) => e.toJson()).toList(),
    };
