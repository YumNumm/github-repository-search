import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repository_search/i18n/strings.g.dart';
import 'package:github_repository_search/model/github/search_param.dart';
import 'package:github_repository_search/model/github/search_response.dart';
import 'package:github_repository_search/model/github/search_response/search_response_item.dart';
import 'package:github_repository_search/model/github/search_response/search_response_license.dart';
import 'package:github_repository_search/model/github/search_response/search_response_owner.dart';
import 'package:github_repository_search/provider/language_colors.dart';
import 'package:github_repository_search/repository/github_repository.dart';
import 'package:github_repository_search/ui/page/search_view/component/repository_search_total_count_widget.dart';
import 'package:github_repository_search/ui/page/search_view/search_view.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/date_symbol_data_local.dart';

class FakeGitHubRepository implements GitHubRepository {
  @override
  Future<SearchResponse> fetch(SearchParam param) {
    return Future.value(
      SearchResponse(
        totalCount: 1,
        incompleteResults: false,
        items: [
          SearchResponseItem(
            id: 1,
            fullName: 'test',
            htmlUrl: 'test',
            description: 'test',
            stargazersCount: 1,
            watchersCount: 1,
            forksCount: 1,
            language: 'dart',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            archived: false,
            fork: false,
            forks: 10,
            hasDownloads: true,
            hasIssues: true,
            hasPages: true,
            hasProjects: true,
            hasWiki: true,
            license: SearchResponseLicense(
              key: 'mit',
              name: 'MIT License',
              spdxId: 'MIT',
              url: 'https://api.github.com/licenses/mit',
            ),
            masterBranch: 'main',
            nodeId: '',
            openIssues: 20,
            openIssuesCount: 20,
            owner: SearchResponseOwner(
              avatarUrl: 'https://avatars.githubusercontent.com/u/73390859?v=4',
              gravatarId: null,
              htmlUrl: 'https://github.com/YumNumm',
              id: 1,
              login: 'yumnumm',
              nodeId: '',
              url: '',
            ),
            private: false,
            pushedAt: DateTime.now(),
            size: 10,
            url: 'https://github.com/YumNumm/github-repository-search',
            watchers: 30,
            topics: [],
          ),
        ],
      ),
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('RepositorySearchList', (tester) async {
    // LanguageColorsを読み込み
    final languageColors = await loadLanguageColors();
    // 言語設定を日本語にする
    LocaleSettings.useDeviceLocale();
    await initializeDateFormatting('ja_JP');

    // Widgetをレンダリングする
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          languageColorsProvider.overrideWithValue(languageColors),
          githubRepository.overrideWithValue(FakeGitHubRepository()),
        ],
        child: TranslationProvider(
          child: const MaterialApp(
            home: SearchPage(),
          ),
        ),
      ),
    );
    // 描画されるまで待つ
    await tester.pump();

    // AppBarがあることを確認
    expect(find.byType(AppBar), findsOneWidget);

    // TextFieldがあることを確認
    expect(find.byType(TextField), findsOneWidget);

    // TextFieldに`flutter`を入力
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pump();

    // 消去ボタンで入力を消去できることを確認
    final clearIconFinder = find.byIcon(Icons.clear);
    // 消去ボタンを押す
    await tester.tap(clearIconFinder);
    await tester.pump();
    final textFieldFinder = find.byType(TextField);
    // TextFieldの値が空になっていることを確認
    expect(tester.widget<TextField>(textFieldFinder).controller!.text, isEmpty);

    // TextFieldに`flutter`を入力
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pump();

    // 検索ボタンを押下
    await tester.tap(find.byType(FloatingActionButton));

    // 検索結果が表示されるまで待機
    await tester.pumpAndSettle();

    // 検索結果が表示されていることを確認
    expect(find.byType(RepositorySearchTotalCountWidget), findsOneWidget);
  });
}
