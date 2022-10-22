import 'package:flutter/material.dart';

/// 設定のセクションを作成するWidget
/// ref: https://github.com/EQMonitor/EQMonitor/blob/main/lib/ui/view/widget/setting/setting_section.dart
class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null)
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 10, left: 20),
            child: Text(
              title!,
              style: TextStyle(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ],
    );
  }
}
