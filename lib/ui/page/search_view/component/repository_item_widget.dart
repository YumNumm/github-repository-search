import 'package:flutter/material.dart';
import 'package:github_repository_search/model/github/search_response/search_response_item.dart';
import 'package:github_repository_search/ui/page/component/language_icon.dart';
import 'package:github_repository_search/ui/router.dart';
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
    final t = Theme.of(context);

    final title = SubstringHighlight(
      text: item.fullName,
      term: term,
      textStyle: t.textTheme.bodyMedium!,
      textStyleHighlight: t.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );

    return InkWell(
      onTap: () => RepositoryRoute(id: item.id).push(context),
      child: ListTile(
        title: title,
        subtitle: Wrap(
          spacing: 6,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_border,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  item.stargazersCount.toString(),
                  style: t.textTheme.bodyMedium,
                ),
                const SizedBox(width: 2),
                Text(
                  'stars',
                  style: t.textTheme.bodySmall,
                )
              ],
            ),
            if (item.language != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LanguageIcon(language: item.language ?? ''),
                  const SizedBox(width: 4),
                  Text(
                    item.language ?? '',
                    style: t.textTheme.bodySmall,
                  ),
                ],
              ),
            //if (item.license != null)
            //  Row(
            //    mainAxisSize: MainAxisSize.min,
            //    children: [
            //      const Icon(
            //        Icons.lock,
            //        size: 16,
            //      ),
            //      const SizedBox(width: 4),
            //      Text(
            //        item.license!.name,
            //        style: t.textTheme.bodySmall,
            //        overflow: TextOverflow.ellipsis,
            //      ),
            //    ],
            //  ),
          ],
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.owner.avatarUrl),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
