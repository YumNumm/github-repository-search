import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../i18n/strings.g.dart';
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
      onNotification: (notification) {
        if (notification.metrics.extentAfter == 0 &&
            (data.value?.isNotEmpty ?? false)) {
          ref.read(repositorySearchViewModel.notifier).loadMoreRepositories();
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
                return RepositorySearchErrorWidget(error);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RepositorySearchErrorWidget extends StatelessWidget {
  const RepositorySearchErrorWidget(
    this.error, {
    super.key,
  });
  final Object error;

  @override
  Widget build(BuildContext context) {
    if (error.runtimeType == DioError) {
      final dioError = error as DioError;
      return SliverFillRemaining(
        child: Card(
          elevation: 0,
          color:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  'assets/75279-error.json',
                ),
                () {
                  switch (dioError.type) {
                    case DioErrorType.connectTimeout:
                    case DioErrorType.receiveTimeout:
                    case DioErrorType.sendTimeout:
                    case DioErrorType.other:
                    case DioErrorType.cancel:
                      return Center(
                        child: Text(t.DioError[dioError.type.name]!.toString()),
                      );
                    case DioErrorType.response:
                      return Center(
                        child: Text(
                          (t.DioError['response'] as Map<String, dynamic>)[
                                      dioError.response!.statusCode.toString()]
                                  ?.toString() ??
                              t.DioError['other']!.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                  }
                }(),
              ],
            ),
          ),
        ),
      );
    }

    return SliverFillRemaining(
      child: Center(
        child: Text('$error'),
      ),
    );
  }
}
