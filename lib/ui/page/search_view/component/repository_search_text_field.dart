import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../i18n/translations.g.dart';
import '../search_view.viewmodel.dart';

class RepositorySearchTextField extends ConsumerWidget {
  const RepositorySearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    final i18n = Translations.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) =>
            ref.read(repositorySearchViewModel.notifier).setParam(
                  value,
                ),
        onEditingComplete: focusNode.unfocus,
        decoration: InputDecoration(
          hintText: i18n.mainScreen.searchPlaceholder,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.clear),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
