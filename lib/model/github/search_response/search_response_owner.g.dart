// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseOwner _$SearchResponseOwnerFromJson(Map<String, dynamic> json) =>
    SearchResponseOwner(
      login: json['login'] as String,
      id: json['id'] as int,
      nodeId: json['node_id'] as String,
      avatarUrl: json['avatar_url'] as String,
      gravatarId: json['gravatar_id'] as String?,
      url: json['url'] as String,
      htmlUrl: json['html_url'] as String,
    );

Map<String, dynamic> _$SearchResponseOwnerToJson(
        SearchResponseOwner instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'avatar_url': instance.avatarUrl,
      'gravatar_id': instance.gravatarId,
      'url': instance.url,
      'html_url': instance.htmlUrl,
    };
