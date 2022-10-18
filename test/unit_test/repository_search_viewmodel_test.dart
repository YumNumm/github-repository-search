import 'package:github_repository_search/model/github/search_response/search_response_item.dart';
import 'package:github_repository_search/ui/page/search_view/search_view.viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';

void main() {
  final container = ProviderContainer();
  test(
    '初期値が空配列である',
    () => expect(
      container.read(repositorySearchViewModel).value,
      <SearchResponseItem>[],
    ),
  );

  test('正しい検索結果を取得できる', () async {
    final viewModel = container.read(repositorySearchViewModel.notifier)
      ..setParam('YumNumm/github-repository-search');
    await viewModel.fetch();
    expect(
      container.read(repositorySearchViewModel).value!.first.fullName,
      'YumNumm/github-repository-search',
    );
  });

  test('検索キーワードセット時にDataは空になる', () async {
    container
        .read(repositorySearchViewModel.notifier)
        .setParam('YumNumm/github-repository-search');
    expect(
      container.read(repositorySearchViewModel).value,
      <SearchResponseItem>[],
    );
  });
}
