# GitHub Repository Search

[![Codemagic build status](https://api.codemagic.io/apps/634a758322ff8df16c567fd5/634a758322ff8df16c567fd4/status_badge.svg)](https://codemagic.io/apps/634a758322ff8df16c567fd5/634a758322ff8df16c567fd4/latest_build)

[![release](https://github.com/YumNumm/github-repository-search/actions/workflows/release.yaml/badge.svg)](https://github.com/YumNumm/github-repository-search/actions/workflows/release.yaml)

[![wakatime](https://wakatime.com/badge/github/YumNumm/github-repository-search.svg)](https://wakatime.com/badge/github/YumNumm/github-repository-search)

## 要件

### 環境

- IDE・SDK・プログラミング言語については、基本的に最新の安定版を利用すること
- 最新の安定版以外を利用する場合は、理由も含めて README に記載すること
- 状態管理パッケージには Provider/Riverpod のいずれかを使うこと
- サードパーティーライブラリについては、オープンソースのものに限り制限しない

### 対象 OS バージョン

基本的に Flutter プロジェクト作成時のバージョンにすること

|         | OS Version |
|---------|------------|
| iOS     | 9.0 ~ 15.2 |
| Android | 4.1 ~ 12   |

※ 本プロジェクト更新時点

### 動作

- 何かしらのキーワードを入力できる
- 入力したキーワードで GitHub のリポジトリを検索できる
- GitHub のリポジトリを検索する際、GitHub API（[`search/repositories`](https://docs.github.com/ja/rest/reference/search#search-repositories)）を利用する
  - [github | Dart Package](https://pub.dev/packages/github) のようなパッケージは利用せず、API を呼ぶ処理を自分で実装すること
- 検索結果は一覧で概要（リポジトリ名）を表示する
- 検索結果のアイテムをタップしたら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示する

## 評価ポイント

- レビューのしやすさ
  - README の充実
  - 適切なコメント
  - GitHub のプルリクエスト機能などの利用
- Git
  - 適切な gitignore の設定
  - 適切なコミット粒度
  - 適切なブランチ運用
- 簡潔性・可読性・安全性・保守性の高いコード
- Dart の言語機能を適切に使いこなせているか
- テスト
  - テストが導入しやすい構成
  - Unit・UI テストがある
- UI/UX
  - エラー発生時の処理
  - 画面回転・様々な画面サイズ対応
  - Theme の適切な利用・ダークモードの対応
  - 多言語対応
  - アニメーションなど
- CI/CD
  - ビルド
  - テスト
  - リント
  - フォーマット
  - 仮のデプロイ環境
  
