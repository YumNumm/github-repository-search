import 'package:flutter/material.dart';
import 'package:github_repository_search/model/github/search_response/search_response_item.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../i18n/strings.g.dart';

class RepositoryItemWidgetViewModel {
  Future<void> onItemPressed(
    BuildContext context,
    SearchResponseItem item,
  ) async {
    final uri = Uri.parse(item.htmlUrl);
    if (await canLaunchUrl(uri)) {
      try {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.repositoryDetailWidget.cannotLaunchUrl(url: uri.toString()),
          ),
        ),
      );
    }
  }
}
