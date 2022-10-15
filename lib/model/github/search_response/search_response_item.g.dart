// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseItem _$SearchResponseItemFromJson(Map<String, dynamic> json) =>
    SearchResponseItem(
      id: json['id'] as int,
      nodeId: json['node_id'] as String,
      fullName: json['full_name'] as String,
      private: json['private'] as bool,
      htmlUrl: json['html_url'] as String,
      description: json['description'] as String?,
      fork: json['fork'] as bool,
      url: json['url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      pushedAt: DateTime.parse(json['pushed_at'] as String),
      size: json['size'] as int,
      stargazersCount: json['stargazers_count'] as int,
      watchersCount: json['watchers_count'] as int,
      language: json['language'] as String?,
      forksCount: json['forks_count'] as int,
      openIssuesCount: json['open_issues_count'] as int,
      masterBranch: json['master_branch'] as String?,
      forks: json['forks'] as int,
      openIssues: json['open_issues'] as int,
      watchers: json['watchers'] as int,
      hasIssues: json['has_issues'] as bool,
      hasProjects: json['has_projects'] as bool,
      hasPages: json['has_pages'] as bool,
      hasWiki: json['has_wiki'] as bool,
      hasDownloads: json['has_downloads'] as bool,
      archived: json['archived'] as bool,
      license: json['license'] == null
          ? null
          : SearchResponseLicense.fromJson(
              json['license'] as Map<String, dynamic>),
      owner:
          SearchResponseOwner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResponseItemToJson(SearchResponseItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'node_id': instance.nodeId,
      'full_name': instance.fullName,
      'private': instance.private,
      'html_url': instance.htmlUrl,
      'description': instance.description,
      'fork': instance.fork,
      'url': instance.url,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'pushed_at': instance.pushedAt.toIso8601String(),
      'size': instance.size,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
      'master_branch': instance.masterBranch,
      'forks': instance.forks,
      'open_issues': instance.openIssues,
      'watchers': instance.watchers,
      'has_issues': instance.hasIssues,
      'has_projects': instance.hasProjects,
      'has_pages': instance.hasPages,
      'has_wiki': instance.hasWiki,
      'has_downloads': instance.hasDownloads,
      'archived': instance.archived,
      'license': instance.license?.toJson(),
      'owner': instance.owner.toJson(),
    };
