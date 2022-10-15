import 'package:dio/dio.dart';
import 'package:flutter_enginner_codecheck/model/github/search_param.dart';
import 'package:flutter_enginner_codecheck/model/github/search_response.dart';

import '../api/repository_api_client.dart';

class GitHubRepository {
  final _repositoryApiClient = RepositoryApiClient(
    Dio(
      BaseOptions(),
    ),
  );

  final String _accept = 'application/vnd.github+json';

  Future<SearchResponse> fetch(SearchParam param) async {
    final dynamic res = await _repositoryApiClient.fetch(
      _accept,
      param.query,
      param.sort?.param,
      param.order?.name,
      param.page,
      param.perPage,
    );
    return SearchResponse.fromJson(res as Map<String, dynamic>);
  }
}
