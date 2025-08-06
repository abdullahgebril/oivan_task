import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: size ?? AppDimensions.loadingIndicatorSizeLarge.w,
      height: size ?? AppDimensions.loadingIndicatorSizeLarge.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (color ?? AppColors.primaryColor).withValues(
          alpha: AppDimensions.alphaDisabled,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingS.w),
        child: CircularProgressIndicator(
          strokeWidth: AppDimensions.loadingIndicatorStrokeWidth.w,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primaryColor,
          ),
        ),
      ),
    ));
  }
}
