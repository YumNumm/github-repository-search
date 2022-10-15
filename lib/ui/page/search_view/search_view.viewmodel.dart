import 'package:flutter_enginner_codecheck/model/github/search_param.dart';
import 'package:flutter_enginner_codecheck/model/github/search_response/search_response_item.dart';
import 'package:flutter_enginner_codecheck/repository/github_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final repositorySearchViewMoel = StateNotifierProvider<
    RepositorySearchViewModel, AsyncValue<List<SearchResponseItem>>>(
  RepositorySearchViewModel.new,
);

/// 検索結果の合計Repo数
final totalRepositoryCountProvider =
    StateProvider<AsyncValue<int?>>((ref) => const AsyncValue.data(null));

/// 検索文字列
final searchRepositoryNameProvider = StateProvider<String?>((ref) => null);

class RepositorySearchViewModel
    extends StateNotifier<AsyncValue<List<SearchResponseItem>>> {
  RepositorySearchViewModel(this.ref) : super(const AsyncValue.data([]));
  final Ref ref;

  final GitHubRepository _gitHubRepository = GitHubRepository();

  /// Infinite Paging のためのページ数
  int page = 1;

  /// パラメータをセット
  void setParam(String query) {
    state = const AsyncData([]);
    ref.read(totalRepositoryCountProvider.notifier).state =
        const AsyncValue.loading();
    ref.read(searchRepositoryNameProvider.notifier).state = query;
  }

  Future<void> fetch({
    bool isLoadMore = false,
  }) async {
    if (ref.read(searchRepositoryNameProvider) == null) {
      return;
    }
    if (isLoadMore) {
      page++;
    } else {
      page = 1;
      ref.read(totalRepositoryCountProvider.notifier).state =
          const AsyncValue.loading();
    }
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);

    state = await AsyncValue.guard(
      () async {
        // 新規部分の取得
        final res = await _gitHubRepository.fetch(
          SearchParam.paging(
            page,
            SearchParam(query: ref.read(searchRepositoryNameProvider)!),
          ),
        );
        ref.read(totalRepositoryCountProvider.notifier).state =
            AsyncValue.data(res.totalCount);

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
      isLoadMore: true,
    );
  }

  Future<void> refresh() async {
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);
    page = 1;
    await fetch();
  }
}
