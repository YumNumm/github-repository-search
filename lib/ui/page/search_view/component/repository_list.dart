import 'package:flutter/material.dart';
import 'package:flutter_enginner_codecheck/model/github/search_response/search_response_item.dart';

class RepositoryList extends StatelessWidget {
  const RepositoryList({
    required this.items,
    super.key,
  });

  final List<SearchResponseItem> items;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.fullName),
            subtitle: Text(item.fullName),
          );
        },
        childCount: items.length,
      ),
    );
  }
}
