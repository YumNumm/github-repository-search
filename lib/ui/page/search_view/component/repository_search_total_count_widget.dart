import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/ui/page/search_view/search_view.viewmodel.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../../i18n/translations.g.dart';

class RepositorySearchTotalCountWidget extends ConsumerWidget {
  const RepositorySearchTotalCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(totalRepositoryCountProvider);
    final t = Theme.of(context);
    final i18n = Translations.of(context);

    return state.when<Widget>(
      data: (value) {
        if (value == null) {
          return const SizedBox.shrink();
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SubstringHighlight(
                text: i18n.mainScreen.repositoryResult(count: value),
                term: value.toString(),
                textStyle: t.textTheme.bodyMedium!,
                textStyleHighlight: t.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
