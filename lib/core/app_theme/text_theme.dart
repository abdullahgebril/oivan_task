import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTextTheme {
  const AppTextTheme._();

  static String get fontFamily => GoogleFonts.cairo().fontFamily!;

  // Display text styles
  static TextStyle displayLarge = _baseTextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
    height: 1.7,
    color: AppColors.primaryColor,
  );

  static TextStyle displayMedium = _baseTextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    height: 0.95.h,
    color: AppColors.white,
  );

  static TextStyle displaySmall = _baseTextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w400,
    height: 1.22,
    color: AppColors.textColor,
  );

  // Headline text styles
  static TextStyle headlineLarge = _baseTextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w400,
    height: 1.25,
    color: AppColors.textColor,
  );

  static TextStyle headlineMedium = _baseTextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textColor,
  );

  static TextStyle headlineSmall = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.33,
    color: AppColors.darkGrey,
  );

  // Title text styles
  static TextStyle titleLarge = _baseTextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    height: 1.27,
    color: AppColors.tertiaryColor,
  );

  static TextStyle titleMedium = _baseTextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.primaryColor,
  );

  static TextStyle titleSmall = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43,
    color: AppColors.mediumGrey,
  );

  // Body text styles
  static TextStyle bodyLarge = _baseTextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textColor,
  );

  static TextStyle bodyMedium = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.43,
    color: AppColors.textColor,
  );

  static TextStyle bodySmall = _baseTextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.33,
    color: AppColors.textColor2,
  );

  // Label text styles
  static TextStyle labelLarge = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.43,
    color: AppColors.textColor,
  );

  static TextStyle labelMedium = _baseTextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    height: 1.33,
    color: AppColors.textFieldHintColor,
  );

  static TextStyle labelSmall = _baseTextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.45,
    color: AppColors.textColor,
  );

  // Custom text styles for specific use cases
  static TextStyle button = _baseTextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.43,
    color: Colors.white,
  );

  static TextStyle caption = _baseTextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.textColor2,
  );

  static TextStyle appBarTitle = _baseTextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle userCardTitle = _baseTextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static TextStyle userCardSubtitle = _baseTextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.mediumGrey,
  );

  static TextStyle userCardLocation = _baseTextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGrey,
  );

  static TextStyle reputationHistoryTitle = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static TextStyle reputationHistoryDate = _baseTextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGrey,
  );

  static TextStyle reputationHistoryPostId = _baseTextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGrey,
  );

  static TextStyle reputationChange = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.successColor,
  );

  static TextStyle emptyStateTitle = _baseTextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static TextStyle emptyStateSubtitle = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGrey,
  );

  static TextStyle errorStateTitle = _baseTextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static TextStyle errorStateMessage = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.mediumGrey,
  );

  static TextStyle buttonWhiteText = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle userProfileName = _baseTextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );

  static TextStyle userProfileInitial = _baseTextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle userReputationValue = _baseTextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: Color(0xFFEE7930),
  );

  static TextStyle navLabelSelected = _baseTextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: Color(0xFFEE7930),
  );

  // Helper method to create dynamic reputation change style
  static TextStyle reputationChangeWithColor(Color color) => _baseTextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: color,
      );

  // Helper method to get TextTheme for Material Design
  static TextTheme getTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  static TextStyle _baseTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      height: height,
      color: color,
    );
  }
}
