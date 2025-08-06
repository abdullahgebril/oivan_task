import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onRetry;
  final String? buttonText;

  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.onRetry,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXXL.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppDimensions.iconLarge.sp,
              color: AppColors.mediumGrey.withValues(
                alpha: AppDimensions.alphaMedium,
              ),
            )
                .animate()
                .fadeIn(duration: AppDimensions.animationDurationSlow.ms)
                .scale(
                  begin: Offset(AppDimensions.animationScaleStart,
                      AppDimensions.animationScaleStart),
                  end: Offset(AppDimensions.animationScaleEnd,
                      AppDimensions.animationScaleEnd),
                  duration: AppDimensions.animationDurationSlow.ms,
                  curve: Curves.easeOutBack,
                ),
            SizedBox(height: AppDimensions.paddingXXL.h),
            Text(
              title,
              style: AppTextTheme.emptyStateTitle,
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: AppDimensions.animationDelayFast.ms),
            SizedBox(height: AppDimensions.paddingM.h),
            Text(
              subtitle,
              style: AppTextTheme.emptyStateSubtitle,
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: AppDimensions.animationDelayNormal.ms),
            if (onRetry != null) ...[
              SizedBox(height: AppDimensions.paddingXXXL.h),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingXXXL.w,
                    vertical: AppDimensions.paddingM.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusL.r),
                  ),
                ),
                child: Text(
                  buttonText ?? LocaleKeys.actions_try_again.tr(),
                  style: AppTextTheme.buttonWhiteText,
                ),
              )
                  .animate()
                  .fadeIn(delay: AppDimensions.animationDelaySlow.ms)
                  .slideY(
                    begin: AppDimensions.animationSlideStart,
                    end: AppDimensions.animationSlideEnd,
                    duration: AppDimensions.animationDurationNormal.ms,
                    curve: Curves.easeOut,
                  ),
            ],
          ],
        ),
      ),
    );
  }
}
