import 'package:flutter/material.dart';

class AppLanguages {
  static const String en = 'en';
  static const String ar = 'ar';

  static const List<Locale> supportedLanguages = [
    Locale(en),
    Locale(ar),
  ];

  static const Locale enLocale = Locale(en);
  static const Locale arLocale = Locale(ar);

  const AppLanguages._();
}
