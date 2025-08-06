import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oivan_task/app.dart';
import 'package:oivan_task/core/constants/app_lang.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguages.supportedLanguages,
      path: 'assets/translations',
      fallbackLocale: AppLanguages.enLocale,
      startLocale: AppLanguages.enLocale,
      saveLocale: true,
      useOnlyLangCode: true,
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}
