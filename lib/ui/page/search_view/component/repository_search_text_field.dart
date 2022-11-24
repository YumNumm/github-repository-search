import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/ui/page/search_view/component/repository_search_text_field.viewmodel.dart';

import '../../../../i18n/strings.g.dart';

class RepositorySearchTextField extends ConsumerWidget {
  const RepositorySearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = RepositorySearchTextFieldViewModel();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: viewModel.controller,
        focusNode: viewModel.focusNode,
        onChanged: (value) => viewModel.onChanged(value, ref),
        onFieldSubmitted: (value) => viewModel.onFieldSubmitted(value, ref),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: t.mainView.searchPlaceholder,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () => viewModel.clear(ref),
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
