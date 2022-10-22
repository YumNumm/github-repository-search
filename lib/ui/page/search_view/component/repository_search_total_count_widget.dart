import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/ui/page/search_view/search_view.viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../../i18n/strings.g.dart';

class RepositorySearchTotalCountWidget extends ConsumerWidget {
  const RepositorySearchTotalCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(totalRepositoryCountProvider);
    final theme = Theme.of(context);
    final numberFormatter = NumberFormat('#,###');

    return state.when<Widget>(
      data: (value) {
        if (value == null) {
          return const SizedBox.shrink();
        }
        final formattedCount = numberFormatter.format(value);
        return Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SubstringHighlight(
              text: t.mainView.repositoryResult(count: formattedCount),
              term: formattedCount,
              overflow: TextOverflow.visible,
              textStyle: theme.textTheme.bodyMedium!,
              textStyleHighlight: theme.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
