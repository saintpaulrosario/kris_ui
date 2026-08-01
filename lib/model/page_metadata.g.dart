// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageMetadata _$PageMetadataFromJson(Map<String, dynamic> json) => PageMetadata(
  size: (json['size'] as num).toInt(),
  number: (json['number'] as num).toInt(),
  totalElements: (json['totalElements'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
);

Map<String, dynamic> _$PageMetadataToJson(PageMetadata instance) =>
    <String, dynamic>{
      'size': instance.size,
      'number': instance.number,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };
