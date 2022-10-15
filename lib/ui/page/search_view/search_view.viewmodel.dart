import 'package:flutter_enginner_codecheck/model/github/search_param.dart';
import 'package:flutter_enginner_codecheck/model/github/search_response/search_response_item.dart';
import 'package:flutter_enginner_codecheck/repository/github_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final repositorySearchViewMoel = StateNotifierProvider<
    RepositorySearchViewModel, AsyncValue<List<SearchResponseItem>>>(
  (ref) => RepositorySearchViewModel(),
);

final totalRepositoryCountProvider =
    StateProvider<AsyncValue<int?>>((ref) => const AsyncValue.data(null));

class RepositorySearchViewModel
    extends StateNotifier<AsyncValue<List<SearchResponseItem>>> {
  RepositorySearchViewModel() : super(const AsyncValue.data([]));

  final GitHubRepository _gitHubRepository = GitHubRepository();

  int page = 1;
  String latestQuery = '';

  Future<void> fetch({
    required String query,
    bool isLoadMore = false,
  }) async {
    if (query == '') {
      throw Exception('query is empty');
    }
    if (latestQuery != query) {
      state = const AsyncValue.data([]);
      latestQuery = query;
    }
    if (isLoadMore) {
      page++;
    } else {
      page = 1;
    }
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);
    state = await AsyncValue.guard(
      () async {
        // 新規部分の取得
        final res = await _gitHubRepository.fetch(
          SearchParam(
            query: query,
            page: page,
            perPage: 50,
          ),
        );

        // 既存のデータと新規のデータを結合
        return [
          ...state.value ?? [],
          ...res.items,
        ];
      },
    );
  }

  void loadMore() {
    if (state.isLoading || state.isRefreshing) {
      return;
    }
    fetch(
      query: latestQuery,
      isLoadMore: true,
    );
  }

  Future<void> refresh() async {
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);
    page = 1;
    await fetch(
      query: latestQuery,
    );
  }
}
