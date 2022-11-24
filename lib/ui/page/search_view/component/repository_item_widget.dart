import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:github_repository_search/ui/page/search_view/component/repository_item_widget.viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../../../i18n/strings.g.dart';
import '../../../../model/github/search_response/search_response_item.dart';
import '../../component/language_icon.dart';

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
    final numberFormatter = NumberFormat('#,###');

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
                numberFormatter.format(item.stargazersCount),
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
      expanded: RepositoryDetailWidget(
        controller: controller,
        header: header,
        item: item,
      ),
    );
  }
}

class RepositoryDetailWidget extends StatelessWidget {
  RepositoryDetailWidget({
    super.key,
    required this.header,
    required this.item,
    required this.controller,
  });

  final ListTile header;
  final SearchResponseItem item;
  final ExpandableController controller;

  ///
  final numberFormatter = NumberFormat('#,###');
  final dateFormatter =
      DateFormat.yMMMd(LocaleSettings.currentLocale.languageTag);

  final RepositoryItemWidgetViewModel viewModel =
      RepositoryItemWidgetViewModel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.secondaryContainer.withOpacity(0.4),
      elevation: 0,
      child: InkWell(
        onTap: controller.toggle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IgnorePointer(
              child: header,
            ),
            const Divider(),
            // Description
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (item.description != null)
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        item.description ?? '',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  // Watchers
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          numberFormatter.format(item.watchersCount),
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          t.repositoryDetailWidget.watchers,
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  // Forks
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.call_split,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          numberFormatter.format(item.forksCount),
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          t.repositoryDetailWidget.forks,
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  // Open issues
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          numberFormatter.format(item.openIssuesCount),
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          t.repositoryDetailWidget.openIssues,
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),

                  // License
                  if (item.license != null)
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.book,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.license!.name,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  // Created at
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          t.repositoryDetailWidget.createdAt(
                            date:
                                dateFormatter.format(item.createdAt.toLocal()),
                          ),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  // Updated at
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          t.repositoryDetailWidget.updatedAt(
                            date:
                                dateFormatter.format(item.updatedAt.toLocal()),
                          ),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  // Owner
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.owner.login,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Open in browser
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: FloatingActionButton.extended(
                  heroTag: 'RepositoryDetailWidget:${item.hashCode}',
                  onPressed: () => viewModel.onItemPressed(context, item),
                  elevation: 1,
                  label: Text(t.repositoryDetailWidget.goToRepository),
                  icon: const Icon(Icons.open_in_new),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
