import 'package:dio/dio.dart';
import 'package:flutter_enginner_codecheck/model/github/search_param.dart';
import 'package:flutter_enginner_codecheck/model/github/search_response/search_response_item.dart';
import 'package:flutter_enginner_codecheck/repository/github_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final repositorySearchViewMoel = StateNotifierProvider<
    RepositorySearchViewModel, AsyncValue<List<SearchResponseItem>>>(
  (ref) => RepositorySearchViewModel(),
);

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
    if (latestQuery != query) {
      state = const AsyncValue.data([]);
    }
    if (isLoadMore) {
      page++;
    } else {
      page = 1;
    }
    state = const AsyncValue.loading();
    try {
      // 新規部分の取得
      final res = await _gitHubRepository.fetch(
        SearchParam(
          query: query,
          page: page,
          perPage: 10,
        ),
      );
      // 既存のデータと新規のデータを結合
      state = AsyncValue.data(
        [
          if (state.hasValue) ...state.value!,
          ...res.items,
        ],
      );
    } on Exception catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    } on DioError catch (error) {
      state = AsyncValue.error(error.message, StackTrace.current);
    }
  }

  void loadMore() {
    if (state.isLoading || state.isRefreshing) {
      return;
    }
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);
    page++;
    fetch(
      query: latestQuery,
      isLoadMore: true,
    );
  }

  void refresh() {
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);
    page = 1;
    fetch(
      query: latestQuery,
    );
  }
}
