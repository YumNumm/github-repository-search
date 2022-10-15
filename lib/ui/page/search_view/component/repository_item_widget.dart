import 'package:flutter/material.dart';
import 'package:flutter_enginner_codecheck/model/github/search_response/search_response_item.dart';
import 'package:substring_highlight/substring_highlight.dart';

class RepositoryItemWidget extends StatelessWidget {
  const RepositoryItemWidget({
    super.key,
    required this.item,
    required this.term,
  });

  final SearchResponseItem item;
  final String term;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SubstringHighlight(
        text: item.fullName,
        term: term,
        textStyle: Theme.of(context).textTheme.bodyMedium!,
        textStyleHighlight: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(item.updatedAt.toString()),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.owner.avatarUrl),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
