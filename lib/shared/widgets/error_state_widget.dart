import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

class ErrorStateWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const ErrorStateWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXXL.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppDimensions.iconLarge.w,
              height: AppDimensions.iconLarge.w,
              decoration: BoxDecoration(
                color: AppColors.errorColor
                    .withValues(alpha: AppDimensions.alphaDisabled),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: AppDimensions.iconXXXL.sp,
                color: AppColors.errorColor,
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
              LocaleKeys.errors_general_error.tr(),
              style: AppTextTheme.errorStateTitle,
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: AppDimensions.animationDelayFast.ms),
            SizedBox(height: AppDimensions.paddingM.h),
            Text(
              message ?? LocaleKeys.errors_general_error_subtitle.tr(),
              style: AppTextTheme.errorStateMessage,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
                  LocaleKeys.actions_try_again.tr(),
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
