import 'package:flutter/material.dart';
import 'package:flutter_enginner_codecheck/ui/page/search_view/search_view.viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchViewAppBar(),
      body: Column(
        children: const [
          RepositorySearchTextField(),
          Expanded(child: RepositorySearchList()),
        ],
      ),
    );
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
        onChanged: (value) =>
            ref.read(repositorySearchViewMoel.notifier).fetch(query: value),
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
    return data.when<Widget>(
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (items) => ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.fullName),
            subtitle: Text(item.fullName),
          );
        },
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
