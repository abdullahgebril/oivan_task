import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/core/routes/app_route_const.dart';
import 'package:oivan_task/features/bookmarks/presentation/providers/bookmark_provider.dart';
import 'package:oivan_task/features/users/data/model/user_model.dart';
import 'package:oivan_task/features/users/presentation/widgets/user_avatar.dart';

class UserCard extends ConsumerWidget {
  final UserModel user;
  final int index;

  const UserCard({
    super.key,
    required this.user,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedIds = ref.watch(bookmarkedUserIdsProvider);
    final isBookmarked = bookmarkedIds.contains(user.userId);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL.w,
          vertical: AppDimensions.paddingS.h),
      child: InkWell(
        onTap: () {
          context.push(AppRouteConst.userReputationWithId(user.userId));
        },
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL.r),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black
                    .withValues(alpha: AppDimensions.alphaDisabled),
                blurRadius: AppDimensions.shadowBlurRadius,
                offset: Offset(0, AppDimensions.paddingXS),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.paddingL.w),
            child: Row(
              children: [
                UserAvatar(
                  user: user,
                  size: AppDimensions.avatarSizeXL.w,
                  heroTag: 'user_avatar_${user.userId}',
                ),
                SizedBox(width: AppDimensions.paddingM.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName,
                        style: AppTextTheme.userCardTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppDimensions.paddingXS.h),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: AppDimensions.iconS.sp,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: AppDimensions.paddingXS.w),
                          Text(
                            '${user.reputation ?? 0}',
                            style: AppTextTheme.userCardSubtitle,
                          ),
                          if (user.location != null) ...[
                            SizedBox(width: AppDimensions.paddingM.w),
                            Icon(
                              Icons.location_on_outlined,
                              size: AppDimensions.iconS.sp,
                              color: AppColors.mediumGrey,
                            ),
                            SizedBox(width: AppDimensions.paddingXS.w),
                            Expanded(
                              child: Text(
                                user.location!,
                                style: AppTextTheme.userCardLocation,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .read(BookmarkProvider.provider.notifier)
                        .toggleBookmark(user.userId);
                  },
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked
                        ? AppColors.primaryColor
                        : AppColors.mediumGrey,
                    size: AppDimensions.iconL.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: AppDimensions.animationDurationFast.ms,
          delay: Duration(
            milliseconds: (index * AppDimensions.listItemDelayBase)
                .clamp(0, AppDimensions.listItemDelayMax),
          ),
        )
        .slideX(
          begin: AppDimensions.animationSlideStart,
          end: AppDimensions.animationSlideEnd,
          duration: AppDimensions.animationDurationFast.ms,
          delay: Duration(
            milliseconds: (index * AppDimensions.listItemDelayBase)
                .clamp(0, AppDimensions.listItemDelayMax),
          ),
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: Offset(0.95, 0.95),
          end: Offset(1.0, 1.0),
          duration: AppDimensions.animationDurationFast.ms,
          delay: Duration(
            milliseconds: (index * AppDimensions.listItemDelayBase)
                .clamp(0, AppDimensions.listItemDelayMax),
          ),
          curve: Curves.easeOut,
        );
  }
}
