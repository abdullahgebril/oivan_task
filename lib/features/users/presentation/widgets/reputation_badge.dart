import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';

class ReputationBadge extends StatelessWidget {
  final int reputation;

  const ReputationBadge({
    super.key,
    required this.reputation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM.w,
        vertical: AppDimensions.paddingS.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(
          alpha: AppDimensions.alphaDisabled,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: AppDimensions.iconS.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(width: AppDimensions.paddingXS.w),
          Text(
            '$reputation',
            style: AppTextTheme.userReputationValue,
          ),
        ],
      ),
    );
  }
}
