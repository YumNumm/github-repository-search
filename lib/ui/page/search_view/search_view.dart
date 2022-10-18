import 'package:flutter/material.dart';
import 'package:github_repository_search/ui/page/search_view/component/repository_search_app_bar.dart';

import 'component/repository_search_floating_action_button.dart';
import 'component/repository_search_list.dart';
import 'component/repository_search_text_field.dart';
import 'component/repository_search_total_count_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchViewAppBar(),
      floatingActionButton: const RepositorySearchFloatingActionButton(),
      body: Column(
        children: const [
          RepositorySearchTextField(),
          RepositorySearchTotalCountWidget(),
          Expanded(child: RepositorySearchList()),
        ],
      ),
    );
  }
}
