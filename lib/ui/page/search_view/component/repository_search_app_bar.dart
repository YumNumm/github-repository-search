import 'package:flutter/material.dart';
import '../../../router.dart';

import '../../../../i18n/translations.g.dart';

class SearchViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchViewAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Text(t.appName),
      actions: [
        IconButton(
          onPressed: () => const SettingRoute().push(context),
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }
}
