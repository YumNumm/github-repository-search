import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../../../model/github/search_response/search_response_item.dart';
import '../../component/language_icon.dart';
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
    final theme = Theme.of(context);

    final title = SubstringHighlight(
      text: item.fullName,
      term: term,
      textStyle: theme.textTheme.bodyMedium!,
      textStyleHighlight: theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );

    final controller = ExpandableController(initialExpanded: false);

    final header = ListTile(
      onTap: controller.toggle,
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
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(width: 2),
              Text(
                'stars',
                style: theme.textTheme.bodySmall,
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
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
        ],
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.owner.avatarUrl),
        backgroundColor: Colors.transparent,
      ),
    );

    return ExpandablePanel(
      key: Key(item.fullName),
      controller: controller,
      theme: ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        hasIcon: true,
        iconColor: theme.iconTheme.color,
        iconPadding: const EdgeInsets.symmetric(vertical: 16),
        animationDuration: const Duration(milliseconds: 300),
      ),
      collapsed: Card(
        elevation: 0,
        color: Colors.transparent,
        child: header,
      ),
      expanded: Card(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
        elevation: 0,
        child: InkWell(
          onTap: controller.toggle,
          child: Column(
            children: [
              IgnorePointer(
                child: header,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
