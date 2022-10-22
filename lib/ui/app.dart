import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../i18n/strings.g.dart';
import '../provider/setting/theme_provider.dart';
import 'router.dart';
import 'theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeProvider = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp.router(
        title: 'GitHub Repository Search',
        theme:
            lightTheme(themeModeProvider.useDynamicColor ? lightDynamic : null),
        darkTheme:
            darkTheme(themeModeProvider.useDynamicColor ? darkDynamic : null),
        themeMode: themeModeProvider.themeMode,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: LocaleSettings.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        useInheritedMediaQuery: true,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
