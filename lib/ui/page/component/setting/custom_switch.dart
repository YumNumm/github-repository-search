import 'package:flutter/material.dart';

/// 設定時のスイッチWidget
/// ref: https://github.com/EQMonitor/EQMonitor/blob/main/lib/ui/view/widget/setting/custom_switch.dart
class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.onChanged,
    required this.value,
  });
  final ValueChanged<bool> onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: SizedBox(
        height: 25,
        width: 50,
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              height: 25,
              width: 50,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25),
                ),
                color: value
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondaryContainer,
              ),
            ),
            AnimatedAlign(
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      value ? theme.colorScheme.primaryContainer : Colors.white,
                  boxShadow: [
                    if (value)
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.15),
                        spreadRadius: 0.5,
                        blurRadius: 1,
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
