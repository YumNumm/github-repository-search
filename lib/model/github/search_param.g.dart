// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchParam _$SearchParamFromJson(Map<String, dynamic> json) => SearchParam(
      query: json['q'] as String,
      sort: $enumDecodeNullable(_$SearchParamSortEnumMap, json['sort']),
      order: $enumDecodeNullable(_$SearchParamOrderEnumMap, json['order']),
      page: json['page'] as int?,
      perPage: json['per_page'] as int?,
    );

Map<String, dynamic> _$SearchParamToJson(SearchParam instance) =>
    <String, dynamic>{
      'q': instance.query,
      'sort': _$SearchParamSortEnumMap[instance.sort],
      'order': _$SearchParamOrderEnumMap[instance.order],
      'page': instance.page,
      'per_page': instance.perPage,
    };

const _$SearchParamSortEnumMap = {
  SearchParamSort.stars: 'stars',
  SearchParamSort.forks: 'forks',
  SearchParamSort.helpWantedIssues: 'help-wanted-issues',
  SearchParamSort.updated: 'updated',
};

const _$SearchParamOrderEnumMap = {
  SearchParamOrder.asc: 'asc',
  SearchParamOrder.desc: 'desc',
};
