import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../search_view/search_view.viewmodel.dart';

class RepositoryView extends ConsumerWidget {
  const RepositoryView({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref
        .watch(repositorySearchViewModel)
        .value!
        .firstWhereOrNull((e) => e.id == id);
    final theme = Theme.of(context);
    if (item == null) {
      throw Exception('不正なページ遷移が行われました');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(item.fullName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // レポジトリ概要
              // Authorのアイコン・名前・レポジトリ名・言語
              Card(
                elevation: 0,
                color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          item.owner.avatarUrl,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TODO(YumNumm): 画面が小さいデバイスだとOverFlowします
                          Text(
                            item.fullName,
                            style: theme.textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(height: 4),
                          Text(item.owner.login),
                        ],
                      ),
                      const Spacer(),
                      if (item.language != null) Text(item.language!),
                    ],
                  ),
                ),
              ),
              // レポジトリの説明

              // Star・Fork・Watch数
            ],
          ),
        ),
      ),
    );
  }
}
