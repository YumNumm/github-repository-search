import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/ui/page/search_view/search_view.viewmodel.dart';

import '../../../i18n/translations.g.dart';

class RepositoryView extends ConsumerWidget {
  const RepositoryView({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref
        .watch(repositorySearchViewModel)
        .value!
        .firstWhereOrNull((e) => e.id == id);
    final t = Theme.of(context);
    final i18n = Translations.of(context);
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
                color: t.colorScheme.secondaryContainer.withOpacity(0.4),
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
                          Text(
                            item.fullName,
                            style: t.textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Flutter',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Text(
                        'Dart',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
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
