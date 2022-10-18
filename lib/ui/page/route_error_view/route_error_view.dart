import 'package:flutter/material.dart';
import 'package:github_repository_search/ui/router.dart';

import '../../../i18n/translations.g.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen(this.error, {super.key});
  final Exception error;

  @override
  Widget build(BuildContext context) {
    final i18n = Translations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(i18n.routeErrorView.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(error.toString()),
            ElevatedButton.icon(
              onPressed: () => const HomeRoute().go(context),
              label: Text(i18n.routeErrorView.back),
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }
}
