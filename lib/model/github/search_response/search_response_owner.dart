import 'package:json_annotation/json_annotation.dart';

part 'search_response_owner.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponseOwner {
  SearchResponseOwner({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
  });

  factory SearchResponseOwner.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseOwnerFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseOwnerToJson(this);

  /// ex. "octocat"
  final String login;

  /// ex. 1
  final int id;

  /// ex. "MDQ6VXNlcjE="
  @JsonKey(name: 'node_id')
  final String nodeId;

  /// ex. "https://github.com/images/error/octocat_happy.gif"
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  /// ex. "41d064eb2195891e12d0413f63227ea7"
  @JsonKey(name: 'gravatar_id')
  final String? gravatarId;

  /// ex. "https://api.github.com/users/octocat"
  final String url;

  /// ex. "https://github.com/octocat"
  @JsonKey(name: 'html_url')
  final String htmlUrl;
}
