import 'package:flutter_enginner_codecheck/model/github/search_response/search_response_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchResponse {
  SearchResponse({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  @JsonKey(name: 'total_count')
  final int totalCount;
  @JsonKey(name: 'incomplete_results')
  final bool incompleteResults;
  final List<SearchResponseItem> items;

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}