import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../i18n/strings.g.dart';
import '../../../provider/setting/theme_provider.dart';

class ThemeChoicePage extends HookConsumerWidget {
  const ThemeChoicePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode =
        ref.watch(themeProvider.select((value) => value.themeMode));
    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.themeModeSetting),
      ),
      body: Column(
        children: [
          // テーマ設定
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ThemeMode.values.length,
            itemBuilder: (context, index) {
              final themeMode = ThemeMode.values[index];
              return RadioListTile(
                title: Text(themeMode.i18nName),
                subtitle: Text(themeMode.i18nDescription),
                value: themeMode.name,
                selected: themeMode.name == currentThemeMode.name,
                groupValue: currentThemeMode.name,
                onChanged: (_) {
                  ref.read(themeProvider.notifier).setTheme(themeMode);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

extension ThemeModeExtension on ThemeMode {
  String get i18nName {
    switch (this) {
      case ThemeMode.system:
        return t.themeModes.system;
      case ThemeMode.light:
        return t.themeModes.light;
      case ThemeMode.dark:
        return t.themeModes.dark;
    }
  }

  String get i18nDescription {
    switch (this) {
      case ThemeMode.system:
        return t.themeModes.systemDescription;
      case ThemeMode.light:
        return t.themeModes.lightDescription;
      case ThemeMode.dark:
        return t.themeModes.darkDescription;
    }
  }
}
