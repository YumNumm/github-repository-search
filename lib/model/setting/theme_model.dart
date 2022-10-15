import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_model.freezed.dart';

@freezed
class ThemeModel with _$ThemeModel {
  const factory ThemeModel({
    /// テーマモード
    @Default(ThemeMode.system) ThemeMode themeMode,

    // TODO(YumNumm): 配色設定の実装
  }) = _ThemeModel;
}
