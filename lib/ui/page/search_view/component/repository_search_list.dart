import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search_view.viewmodel.dart';
import 'repository_item_widget.dart';

class RepositorySearchList extends ConsumerWidget {
  const RepositorySearchList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(repositorySearchViewModel);
    return NotificationListener<ScrollEndNotification>(
      key: const Key('RepositorySearchList'),
      onNotification: (notification) {
        if (notification.metrics.extentAfter == 0 &&
            (data.value?.isNotEmpty ?? false)) {
          ref.read(repositorySearchViewModel.notifier).loadMore();
          return true;
        }
        return false;
      },
      child: Scrollbar(
        child: CustomScrollView(
          slivers: [
            data.when<Widget>(
              data: (items) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == items.length) {
                        // InfiniteScroll Indicator
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }
                      final item = items[index];
                      return RepositoryItemWidget(
                        item: item,
                        term: ref.watch(searchRepositoryNameProvider) ?? '',
                      );
                    },
                    childCount: items.length + (data.isLoading ? 1 : 0),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
              error: (error, stack) {
                if (data.hasValue) {
                  final items = data.value!;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == items.length) {
                          // Error Widget
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        final item = items[index];
                        return RepositoryItemWidget(
                          item: item,
                          term: ref.watch(searchRepositoryNameProvider) ?? '',
                        );
                      },
                      childCount: items.length + (data.isLoading ? 1 : 0),
                    ),
                  );
                }
                return SliverFillRemaining(
                  // TODO(YumNumm): 例外処理
                  child: Center(
                    child: Text('$error'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
