import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../i18n/strings.g.dart';
import 'language_choice_page.viewmodel.dart';

class LanguageChoicePage extends HookConsumerWidget {
  const LanguageChoicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings.languageSetting),
      ),
      body: Column(
        children: [
          // テーマ設定
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: LocaleSettings.supportedLocalesRaw.length,
            itemBuilder: (context, index) {
              final lang = LocaleSettings.supportedLocalesRaw[index];
              return RadioListTile<String>(
                title: Text(t.locales[lang]!),
                value: lang,
                selected: lang == currentLanguage.languageCode.toLowerCase(),
                groupValue: currentLanguage.languageCode.toLowerCase(),
                onChanged: (_) =>
                    ref.read(languageProvider.notifier).setLanguage(lang),
              );
            },
          ),
        ],
      ),
    );
  }
}
