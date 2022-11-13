import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../i18n/strings.g.dart';
import '../search_view.viewmodel.dart';

class RepositorySearchFloatingActionButton extends ConsumerWidget {
  const RepositorySearchFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(repositorySearchViewModel);
    return state.when<Widget>(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (data) => FloatingActionButton.extended(
        heroTag: 'RepositorySearchFloatingActionButton',
        onPressed: () {
          primaryFocus?.unfocus();
          ref.read(repositorySearchViewModel.notifier).fetch();
        },
        label: Text(t.mainView.search),
        icon: const Icon(Icons.search),
      ),
    );
  }
}
