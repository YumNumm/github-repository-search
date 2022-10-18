import 'dart:ui';

class LanguageColor {
  LanguageColor({
    required this.color,
    required this.name,
    required this.url,
  });

  factory LanguageColor.fromJson(Map<String, dynamic> j) {
    final tmpColorCode =
        int.tryParse(j['color'].toString().substring(1), radix: 16);
    return LanguageColor(
      color: tmpColorCode == null
          ? null
          : Color(
              tmpColorCode + 0xFF000000,
            ),
      name: j['name'].toString(),
      url: j['url'].toString(),
    );
  }

  final Color? color;
  final String name;
  final String url;
}
