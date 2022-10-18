import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/model/github/search_param.dart';
import 'package:github_repository_search/model/github/search_response.dart';

import '../api/repository_api_client.dart';

final githubRepository =
    Provider<GitHubRepository>((ref) => GitHubRepository());

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
      'YumNumm',
      param.query,
      param.sort?.param,
      param.order?.name,
      param.page,
      param.perPage,
    );
    return SearchResponse.fromJson(res as Map<String, dynamic>);
  }
}
