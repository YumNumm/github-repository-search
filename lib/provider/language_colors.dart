import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/language-color/language_color.dart';

/// [LanguageColor]のリストを保持するProvider
final languageColorsProvider =
    Provider<List<LanguageColor>>((ref) => throw UnimplementedError());

/// LanguageColorのリストをassetsから読み取る
Future<List<LanguageColor>> loadLanguageColors() async {
  final fileData = await rootBundle.loadString('assets/colors.json');
  final json = (jsonDecode(fileData) as List<dynamic>)
      .map((dynamic e) => e as Map<String, dynamic>);
  return json.map(LanguageColor.fromJson).toList();
}
