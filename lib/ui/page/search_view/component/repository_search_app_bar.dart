import 'package:flutter/material.dart';

import '../../../../i18n/translations.g.dart';

class SearchViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchViewAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final i18n = Translations.of(context);

    return AppBar(
      title: Text(i18n.appName),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
