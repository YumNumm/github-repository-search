import 'dart:developer';

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

    return data.when<Widget>(
      data: (items) {
        return NotificationListener<ScrollEndNotification>(
          onNotification: (notification) => ref
              .read(repositorySearchViewModel.notifier)
              .onNotification(notification),
          child: Scrollbar(
            child: ListView.builder(
              itemCount: items.length + (data.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
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
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      error: (error, stack) {
        return RepositorySearchErrorWidget(error);
      },
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
      log(dioError.type.toString());
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              'assets/75279-error.json',
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: () {
                switch (dioError.type) {
                  case DioErrorType.connectTimeout:
                  case DioErrorType.receiveTimeout:
                  case DioErrorType.sendTimeout:
                  case DioErrorType.other:
                  case DioErrorType.cancel:
                    return Center(
                      child: Text(
                        t.DioError[dioError.type.name]!.toString(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    );
                  case DioErrorType.response:
                    return Center(
                      child: Text(
                        (dioError.response != null)
                            ? (t.DioError['response'] as Map<String, dynamic>)[
                                        dioError.response!.statusCode
                                            .toString()]
                                    ?.toString() ??
                                t.DioError['other']!.toString()
                            : t.DioError['other']!.toString(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    );
                }
              }(),
            ),
          ],
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
