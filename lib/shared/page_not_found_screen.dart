import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(LocaleKeys.page_not_found.tr()),
      ),
    );
  }
}
