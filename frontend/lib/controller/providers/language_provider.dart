import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale appLanguage = const Locale("en");
  String appCurrentLanguage = "English";
  Map<String, Locale> languages = {
    "English": const Locale("en"),
    "Marathi": const Locale("mr"),
  };

  void changeLanguage({
    required String language,
  }) {
    appCurrentLanguage = language;
    appLanguage = languages[language]!;
    notifyListeners();
  }
}
