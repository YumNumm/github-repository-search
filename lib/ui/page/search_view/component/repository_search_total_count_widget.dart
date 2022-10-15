import 'package:flutter/material.dart';
import 'package:flutter_enginner_codecheck/ui/page/search_view/search_view.viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                alignment: WrapAlignment.end,
                children: [
                  Text(
                    '$value',
                    style: t.textTheme.bodyLarge,
                    overflow: TextOverflow.visible,
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    'Repository results',
                    overflow: TextOverflow.visible,
                  ),
                ],
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
