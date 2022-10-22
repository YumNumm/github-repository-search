import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../provider/setting/theme_provider.dart';
import '../../../provider/shared_preferences.dart';

import '../../../i18n/translations.g.dart';

const int android12SdkVersion = 31;

final isMaterialYouSupportedFutureProvider = FutureProvider<bool>((ref) async {
  if (Platform.isAndroid) {
    final sdkVersion = await _getAndroidSdkVersion();
    return sdkVersion >= android12SdkVersion;
  }
  return false;
});

Future<int> _getAndroidSdkVersion() async {
  final info = await DeviceInfoPlugin().androidInfo;
  return info.version.sdkInt;
}

class SettingViewModel {
  void onMaterialYouButtonTap(WidgetRef ref) => ref
      .read(themeProvider.notifier)
      .setUseDynamicColor(!ref.read(themeProvider).useDynamicColor);
}

/// 現在の言語
final currentLanguageStreamProvider =
    StreamProvider<AppLocale>((ref) => LocaleSettings.getLocaleStream());


