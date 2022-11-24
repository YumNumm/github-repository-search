import 'package:flutter/material.dart';
import 'package:github_repository_search/model/github/search_param.dart';
import 'package:github_repository_search/model/github/search_response/search_response_item.dart';
import 'package:github_repository_search/repository/github_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final repositorySearchViewModel = StateNotifierProvider<
    RepositorySearchViewModel, AsyncValue<List<SearchResponseItem>>>(
  RepositorySearchViewModel.new,
);

/// 検索結果の合計Repo数
/// nullの場合は検索実行前
final totalRepositoryCountProvider =
    StateProvider<AsyncValue<int?>>((ref) => const AsyncValue.data(null));

/// 検索文字列
final searchRepositoryNameProvider = StateProvider<String?>((ref) => null);

class RepositorySearchViewModel
    extends StateNotifier<AsyncValue<List<SearchResponseItem>>> {
  RepositorySearchViewModel(this.ref) : super(const AsyncValue.data([])) {
    _gitHubRepository = ref.watch(githubRepository);
  }

  final Ref ref;

  late GitHubRepository _gitHubRepository;

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
    // 検索キーワード
    final query = ref.read(searchRepositoryNameProvider);
    if (query == null) {
      return;
    }
    if (isLoadMore) {
      page++;
    } else {
      page = 1;
      // 初回読み込みなので、レポジトリの合計数をクリア
      ref.read(totalRepositoryCountProvider.notifier).state =
          const AsyncValue.loading();
    }
    // 読み込み中にする
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);

    state = await AsyncValue.guard(
      () async {
        // 新規部分の取得
        final res = await _gitHubRepository.fetch(
          SearchParam.paging(
            page,
            SearchParam(query: query),
          ),
        );
        // レポジトリの合計数を更新
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

  void loadMoreRepositories() {
    // 既に読み込み中なら何もしない
    if (state.isLoading || state.isRefreshing) {
      return;
    }
    fetch(isLoadMore: true);
  }

  Future<void> refresh() async {
    state =
        const AsyncLoading<List<SearchResponseItem>>().copyWithPrevious(state);
    page = 1;
    await fetch();
  }

  /// 既定のスクロール位置に達した際に発火
  /// 追加読み込み可能な場合 loadMoreRepositories() を呼び出す
  bool onNotification(ScrollEndNotification notification) {
    // 検索結果を取得していない場合・検索結果がない場合は
    // 何もしない
    if (!state.hasValue) {
      return false;
    }
    if (notification.metrics.extentAfter == 0 && (state.value!.isNotEmpty)) {
      // 既に検索結果を全て読み込んでいる場合は、
      // 次のページを読み込む処理を行わない
      if (state.value!.length ==
          (ref.read(totalRepositoryCountProvider).value ?? 0)) {
        return true;
      }
      loadMoreRepositories();
      return true;
    }
    return false;
  }

  /// 検索結果をクリア
  void clear() {
    state = const AsyncValue.data([]);
    ref.read(totalRepositoryCountProvider.notifier).state =
        const AsyncValue.data(null);
  }
}
