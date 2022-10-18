import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../i18n/translations.g.dart';
import '../search_view.viewmodel.dart';

class RepositorySearchFloatingActionButton extends ConsumerWidget {
  const RepositorySearchFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(repositorySearchViewModel);
    final i18n = Translations.of(context);
    if (state.value?.isEmpty ?? true) {
      return FloatingActionButton.extended(
        onPressed: () => ref.read(repositorySearchViewModel.notifier).fetch(),
        label: Text(i18n.mainScreen.search),
        icon: const Icon(Icons.search),
      );
    }
    return const SizedBox.shrink();
  }
}
