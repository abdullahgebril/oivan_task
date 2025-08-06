import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oivan_task/core/cache/local_cache_service.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/core/routes/app_route_const.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';
import 'package:oivan_task/helper/extentions/context_utils_extension.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ref.read(ILocalCacheService.provider).init();

    await Future.delayed(Duration(
      milliseconds: AppDimensions.splashScreenDuration,
    )).then((value) {
      if (mounted) {
        context.go(AppRouteConst.users);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.app_title.tr(),
              style: context.textTheme.displayLarge?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate()
                .flip(
                  duration: AppDimensions.splashScreenDuration.ms,
                  curve: Curves.easeInOut,
                )
                .scale(
                  duration: AppDimensions.splashScreenDuration.ms,
                  curve: Curves.easeInOut,
                )
                .shimmer(
                  duration: AppDimensions.splashScreenDuration.ms,
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
          ],
        ),
      ),
    );
  }
}
