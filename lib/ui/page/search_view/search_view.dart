import 'package:flutter/material.dart';
import 'package:flutter_enginner_codecheck/model/github/search_response/search_response_item.dart';
import 'package:flutter_enginner_codecheck/ui/page/search_view/search_view.viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchViewAppBar(),
      floatingActionButton: const RepositorySearchFloatingActionButton(),
      body: Column(
        children: const [
          RepositorySearchTextField(),
          RepositorySearchTotalCountWidget(),
          Expanded(child: RepositorySearchList()),
        ],
      ),
    );
  }
}

class RepositorySearchTotalCountWidget extends ConsumerWidget {
  const RepositorySearchTotalCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(totalRepositoryCountProvider);
    final t = Theme.of(context);
    return state.when<Widget>(
      data: (value) {
        if (value == null) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$value',
                style: t.textTheme.bodyLarge,
              ),
              const SizedBox(width: 2),
              const Text('Repository results'),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}

class RepositorySearchFloatingActionButton extends ConsumerWidget {
  const RepositorySearchFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(repositorySearchViewMoel);
    if (state.value?.isEmpty ?? true) {
      return FloatingActionButton.extended(
        onPressed: () => ref.read(repositorySearchViewMoel.notifier).fetch(),
        label: const Text('検索'),
        icon: const Icon(Icons.search),
      );
    }
    return const SizedBox.shrink();
  }
}

class RepositorySearchTextField extends ConsumerWidget {
  const RepositorySearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        //  onChanged: (value) =>
        //      ref.read(repositorySearchViewMoel.notifier).fetch(query: value),
        onChanged: (value) =>
            ref.read(repositorySearchViewMoel.notifier).setParam(
                  value,
                ),
        decoration: const InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

class RepositorySearchList extends ConsumerWidget {
  const RepositorySearchList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(repositorySearchViewMoel);
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter == 0 &&
            (data.value?.isNotEmpty ?? false)) {
          ref.read(repositorySearchViewMoel.notifier).loadMore();
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
                          child: Center(child: CircularProgressIndicator()),
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
                  child: CircularProgressIndicator(),
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
                            child: CircularProgressIndicator(),
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

class RepositoryItemWidget extends StatelessWidget {
  const RepositoryItemWidget({
    super.key,
    required this.item,
    required this.term,
  });

  final SearchResponseItem item;
  final String term;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SubstringHighlight(
        text: item.fullName,
        term: term,
        textStyle: Theme.of(context).textTheme.bodyMedium!,
        textStyleHighlight: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(item.updatedAt.toString()),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.owner.avatarUrl),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class SearchViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchViewAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('GitHub Repository Search'),
    );
  }
}
