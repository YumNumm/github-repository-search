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

  factory SearchParam.fromQuery(String query) => SearchParam(query: query);
  factory SearchParam.paging(int page, SearchParam param) => SearchParam(
        query: param.query,
        page: page,
        perPage: param.perPage,
        order: param.order,
        sort: param.sort,
      );
  factory SearchParam.fromJson(Map<String, dynamic> json) =>
      _$SearchParamFromJson(json);

  @JsonKey(name: 'q')
  final String query;
  final SearchParamSort? sort;
  final SearchParamOrder? order;
  final int? page;
  @JsonKey(name: 'per_page')
  final int? perPage;

  Map<String, dynamic> toJson() => _$SearchParamToJson(this);
}

/// Sorts the results of your query
enum SearchParamSort {
  stars('stars'),
  forks('forks'),
  @JsonValue('help-wanted-issues')
  helpWantedIssues('help-wanted-issues'),
  updated('updated');

  const SearchParamSort(this.param);
  final String param;
}

enum SearchParamOrder {
  asc,
  desc,
}
