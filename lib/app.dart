import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/app_theme/app_theme.dart';
import 'package:oivan_task/core/events/app_event_listener.dart';
import 'package:oivan_task/core/events/app_events.dart';
import 'package:oivan_task/core/routes/app_route.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';
import 'package:oivan_task/services/toast_notification_service.dart';
import 'package:toastification/toastification.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(GoRouteProvider.routerProvider);

    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          designSize: const Size(
            AppDimensions.screenWidth,
            AppDimensions.screenHeight,
          ),
          builder: (context, child) {
            return AppEventListener(
              onListen: (event) async {
                if (event is SuccessEvent) {
                  toastNotificationService.showSuccess(
                    event.message,
                    context: context,
                  );
                } else if (event is ErrorEvent) {
                  toastNotificationService.showError(
                    event.message,
                    context: context,
                  );
                } else if (event is InfoEvent) {
                  toastNotificationService.showInfo(
                    event.message,
                    context: context,
                  );
                }
              },
              child: MaterialApp.router(
                title: LocaleKeys.app_title.tr(),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerConfig: router,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                builder: (context, child) {
                  return ToastificationWrapper(
                    child: child ?? const SizedBox.expand(),
                  );
                },
              ),
            );
          }),
    );
  }
}
