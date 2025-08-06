import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:oivan_task/core/app_theme/text_theme.dart';
import 'package:oivan_task/core/constants/app_colors.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import 'package:oivan_task/core/routes/app_route_const.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.black
                  .withValues(alpha: AppDimensions.alphaDisabled),
              blurRadius: AppDimensions.shadowBlurRadius,
              offset: Offset(0, -AppDimensions.paddingXS),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _calculateSelectedIndex(context),
          onTap: (index) => _onItemTapped(index, context),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.mediumGrey,
          selectedLabelStyle: AppTextTheme.navLabelSelected,
          unselectedLabelStyle: AppTextTheme.labelSmall,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people_outline,
                size: AppDimensions.iconL.sp,
              ),
              activeIcon: Icon(
                Icons.people,
                size: AppDimensions.iconL.sp,
              ),
              label: LocaleKeys.navigation_users.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark_border,
                size: AppDimensions.iconL.sp,
              ),
              activeIcon: Icon(
                Icons.bookmark,
                size: AppDimensions.iconL.sp,
              ),
              label: LocaleKeys.navigation_bookmarks.tr(),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRouteConst.users)) {
      return 0;
    }
    if (location.startsWith(AppRouteConst.bookmarks)) {
      return 1;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRouteConst.users);
        break;
      case 1:
        context.go(AppRouteConst.bookmarks);
        break;
    }
  }
}
