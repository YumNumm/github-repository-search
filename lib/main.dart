import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/provider/language_colors.dart';
import 'package:github_repository_search/provider/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i18n/translations.g.dart';
import 'ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ),
  );
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    Logger().e(error, stackTrace);
    return true;
  };
  // LanguageColorsを読み込み
  final languageColors = await loadLanguageColors();
  // SharedPreferenceを初期化
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      observers: const [],
      overrides: [
        languageColorsProvider.overrideWithValue(languageColors),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: DevicePreview(
        builder: (context) => TranslationProvider(child: const App()),
      ),
    ),
  );
}

Future<void> onFlutterError(FlutterErrorDetails details) async => Logger().wtf(
      'Error: ${details.exception}',
      details.exception,
    );
