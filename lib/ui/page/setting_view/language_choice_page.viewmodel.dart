import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../i18n/strings.g.dart';
import '../../../provider/shared_preferences.dart';

final languageProvider = StateNotifierProvider<LanguageNotifier, AppLocale>(
  LanguageNotifier.new,
);

/// 多言語対応
class LanguageNotifier extends StateNotifier<AppLocale> {
  LanguageNotifier(this.ref) : super(LocaleSettings.currentLocale) {
    LocaleSettings.getLocaleStream().listen((event) {
      state = event;
    });
  }
  final Ref ref;

  static const String languagePrefsKey = 'language';

  /// 任意の言語を設定
  void setLanguage(String languageCode) {
    LocaleSettings.setLocaleRaw(languageCode);
    _saveSettingsToSharedPrefrences(languageCode);
  }

  /// SharedPreferencesから設定を取得
  String loadFromSharedPrefrences() =>
      ref.read(sharedPreferencesProvider).getString(languagePrefsKey) ??
      LocaleSettings.useDeviceLocale().languageCode;

  static String? getLanguageFromPrefs(SharedPreferences prefs) =>
      prefs.getString(languagePrefsKey);

  /// SharedPreferencesに設定を保存する
  Future<void> _saveSettingsToSharedPrefrences(String languageCode) async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(languagePrefsKey, languageCode);
  }

  List<Locale> get supportedLocales {
    return LocaleSettings.supportedLocales;
  }
}

Future<String?> getCurrentLanguage(SharedPreferences prefs) async {
  return null;
}
