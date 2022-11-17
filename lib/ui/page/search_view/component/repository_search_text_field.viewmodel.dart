import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/ui/page/search_view/search_view.viewmodel.dart';

class RepositorySearchTextFieldViewModel {
  RepositorySearchTextFieldViewModel();

  final focusNode = FocusNode();
  final controller = TextEditingController();

  /// TextFieldクリア時
  void clear(WidgetRef ref) {
    controller.clear();
    ref.read(repositorySearchViewModel.notifier).clear();
  }

  /// TextField内容変更時
  void onChanged(String value, WidgetRef ref) =>
      ref.read(repositorySearchViewModel.notifier).setParam(
            value,
          );

  /// TextField入力完了時
  void onFieldSubmitted(String value, WidgetRef ref) {
    ref.read(repositorySearchViewModel.notifier).fetch();
    focusNode.unfocus();
  }
}
