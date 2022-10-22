import 'package:json_annotation/json_annotation.dart';

import 'search_response_license.dart';
import 'search_response_owner.dart';

part 'search_response_item.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponseItem {
  SearchResponseItem({
    required this.id,
    required this.nodeId,
    required this.fullName,
    required this.private,
    required this.htmlUrl,
    required this.description,
    required this.fork,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.size,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
    required this.forksCount,
    required this.openIssuesCount,
    required this.masterBranch,
    required this.forks,
    required this.openIssues,
    required this.watchers,
    required this.hasIssues,
    required this.hasProjects,
    required this.hasPages,
    required this.hasWiki,
    required this.hasDownloads,
    required this.archived,
    required this.license,
    required this.owner,
    required this.topics,
  });

  factory SearchResponseItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseItemFromJson(json);

  final int id;
  @JsonKey(name: 'node_id')
  final String nodeId;
  @JsonKey(name: 'full_name')
  final String fullName;
  final bool private;
  @JsonKey(name: 'html_url')
  final String htmlUrl;
  final String? description;
  final bool fork;
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'pushed_at')
  final DateTime pushedAt;
  final int size;
  @JsonKey(name: 'stargazers_count')
  final int stargazersCount;
  @JsonKey(name: 'watchers_count')
  final int watchersCount;
  final String? language;
  @JsonKey(name: 'forks_count')
  final int forksCount;
  @JsonKey(name: 'open_issues_count')
  final int openIssuesCount;
  @JsonKey(name: 'master_branch')
  final String? masterBranch;
  final int forks;
  @JsonKey(name: 'open_issues')
  final int openIssues;
  final int watchers;
  @JsonKey(name: 'has_issues')
  final bool hasIssues;
  @JsonKey(name: 'has_projects')
  final bool hasProjects;
  @JsonKey(name: 'has_pages')
  final bool hasPages;
  @JsonKey(name: 'has_wiki')
  final bool hasWiki;
  @JsonKey(name: 'has_downloads')
  final bool hasDownloads;
  final bool archived;
  final SearchResponseLicense? license;
  final SearchResponseOwner owner;
  final List<String> topics;
  Map<String, dynamic> toJson() => _$SearchResponseItemToJson(this);
}
