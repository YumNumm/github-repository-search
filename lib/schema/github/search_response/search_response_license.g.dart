// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_license.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseLicense _$SearchResponseLicenseFromJson(
        Map<String, dynamic> json) =>
    SearchResponseLicense(
      key: json['key'] as String,
      name: json['name'] as String,
      spdxId: json['spdxId'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SearchResponseLicenseToJson(
        SearchResponseLicense instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'spdxId': instance.spdxId,
      'url': instance.url,
    };
