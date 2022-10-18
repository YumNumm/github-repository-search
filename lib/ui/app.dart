import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_repository_search/provider/setting/theme_provider.dart';
import 'package:github_repository_search/ui/router.dart';
import 'package:github_repository_search/ui/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../i18n/translations.g.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeProvider.select((value) => value.themeMode));
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'GitHub Repository Search',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: LocaleSettings.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      useInheritedMediaQuery: true,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
