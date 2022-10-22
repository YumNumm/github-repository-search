import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/language_colors.dart';

/// [language] に対応する色のアイコンを返す
class LanguageIcon extends ConsumerWidget {
  const LanguageIcon({required this.language, super.key});
  final String language;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageColors = ref.watch(languageColorsProvider);
    final color =
        languageColors.firstWhereOrNull((e) => e.name == language)?.color;

    // 色がない場合
    if (color == null) {
      return const Icon(Icons.code);
    }
    // 色がある場合
    else {
      return Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.5,
          ),
        ),
      );
    }
  }
}
