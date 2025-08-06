import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/features/users/data/model/reputation_history_model.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';
import 'package:oivan_task/helper/date_formatter.dart';
import 'package:oivan_task/services/reputation_service.dart';

class ReputationHistoryCard extends StatelessWidget {
  final ReputationHistoryModel history;
  final int index;

  const ReputationHistoryCard({
    super.key,
    required this.history,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final change = history.reputationChange ?? 0;
    final reputationColor = ReputationService.getReputationColorByType(
      history.reputationHistoryType,
      change,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL.w,
          vertical: AppDimensions.paddingS.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(
                alpha: AppDimensions.alphaDisabled,
              ),
              blurRadius: AppDimensions.shadowBlurRadius,
              offset: Offset(0, AppDimensions.paddingXS),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingL.w),
          child: Row(
            children: [
              Container(
                width: AppDimensions.avatarSizeL.w,
                height: AppDimensions.avatarSizeL.w,
                decoration: BoxDecoration(
                  color: reputationColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL.r),
                ),
                child: Icon(
                  ReputationService.getReputationIcon(
                      history.reputationHistoryType),
                  color: reputationColor,
                  size: AppDimensions.iconL.sp,
                ),
              ),
              SizedBox(width: AppDimensions.paddingM.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ReputationService.getReputationDescription(
                          history.reputationHistoryType),
                      style: AppTextTheme.reputationHistoryTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppDimensions.paddingXS.h),
                    Text(
                      DateFormatter.formatTimestamp(history.creationDate),
                      style: AppTextTheme.reputationHistoryDate,
                    ),
                    if (history.postId != null) ...[
                      SizedBox(height: AppDimensions.paddingXS.h),
                      Text(
                        LocaleKeys.reputation_post_id
                            .tr(namedArgs: {'id': '${history.postId}'}),
                        style: AppTextTheme.reputationHistoryPostId,
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM.w,
                    vertical: AppDimensions.paddingS.h),
                decoration: BoxDecoration(
                  color: reputationColor.withValues(
                    alpha: AppDimensions.alphaDisabled,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusFull.r),
                ),
                child: Text(
                  ReputationService.formatReputationChange(change),
                  style:
                      AppTextTheme.reputationChangeWithColor(reputationColor),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: AppDimensions.animationDurationNormal.ms,
          delay: Duration(
            milliseconds: index * AppDimensions.animationDelayNormal,
          ),
        )
        .slideX(
          begin: AppDimensions.animationSlideStart,
          end: AppDimensions.animationSlideEnd,
          duration: AppDimensions.animationDurationNormal.ms,
          delay: Duration(
            milliseconds: index * AppDimensions.animationDelayNormal,
          ),
          curve: Curves.easeOut,
        );
  }
}
