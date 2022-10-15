import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/setting/theme_model.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeModel>(
  (ref) => ThemeNotifier(),
);

/// テーマモードを管理するProvider
/// ref: https://github.com/EQMonitor/EQMonitor/blob/main/lib/provider/setting/theme_controller.dart
class ThemeNotifier extends StateNotifier<ThemeModel> {
  ThemeNotifier()
      : super(
          const ThemeModel(
            themeMode: ThemeMode.system,
          ),
        ) {
    loadSettingsFromSharedPrefrences();
  }

  final String prefsKey = 'themeMode';

  /// ## SharedPreferencesから設定を取得
  /// デフォルトはThemeMode.system
  Future<void> loadSettingsFromSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString(prefsKey);
    final themeModeEnum = ThemeMode.values.firstWhere(
      (element) => element.name == themeMode,
      orElse: () => ThemeMode.system,
    );
    state = state.copyWith(
      themeMode: themeModeEnum,
    );
  }

  /// ## SharedPreferencesに設定を保存する
  Future<void> _saveSettingsToSharedPrefrences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(prefsKey, state.themeMode.name);
  }

  /// ## テーマを変更
  /// [themeMode] テーマモード
  /// 変更後、SharedPreferencesに設定を保存します
  void setTheme(ThemeMode themeMode) {
    state = state.copyWith(
      themeMode: themeMode,
    );
    _saveSettingsToSharedPrefrences();
  }

  /// ## ダークモードかどうか
  /// システム設定のテーマも考慮します
  bool get isDarkMode => (state.themeMode == ThemeMode.system)
      ? (SchedulerBinding.instance.window.platformBrightness == Brightness.dark)
      : state.themeMode == ThemeMode.dark;
}
