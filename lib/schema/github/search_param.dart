import 'package:json_annotation/json_annotation.dart';

part 'search_param.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchParam {
  SearchParam({
    required this.query,
    this.sort,
    this.order,
    this.page,
    this.perPage,
  });

  factory SearchParam.fromJson(Map<String, dynamic> json) =>
      _$SearchParamFromJson(json);

  @JsonKey(name: 'q')
  final String query;
  final SearchParamSort? sort;
  final String? order;
  final int? page;
  @JsonKey(name: 'per_page')
  final int? perPage;

  Map<String, dynamic> toJson() => _$SearchParamToJson(this);
}

/// Sorts the results of your query
enum SearchParamSort {
  @JsonValue('stars')
  stars,
  @JsonValue('forks')
  forks,
  @JsonValue('help-wanted-issues')
  helpWantedIssues,
  @JsonValue('updated')
  updated,
}

enum SearchParamOrder {
  @JsonValue('asc')
  asc,
  @JsonValue('desc')
  desc,
}
