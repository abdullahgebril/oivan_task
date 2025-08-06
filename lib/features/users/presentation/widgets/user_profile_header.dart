import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/features/users/data/model/user_model.dart';
import 'package:oivan_task/features/users/presentation/widgets/user_avatar.dart';
import 'package:oivan_task/features/users/presentation/widgets/reputation_badge.dart';

class UserProfileHeader extends StatelessWidget {
  final UserModel user;

  const UserProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.radiusXXL.r),
            topRight: Radius.circular(AppDimensions.radiusXXL.r),
          ),
        ),
        padding: EdgeInsets.all(AppDimensions.paddingXL.w),
        child: Row(
          children: [
            UserAvatar(
              user: user,
              size: AppDimensions.avatarSizeXXL.w,
              heroTag: 'user_avatar_${user.userId}',
            ),
            SizedBox(width: AppDimensions.paddingL.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    style: AppTextTheme.userProfileName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppDimensions.paddingS.h),
                  ReputationBadge(reputation: user.reputation ?? 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
