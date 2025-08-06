import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';
import '../constants/app_colors.dart';
import 'text_theme.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      // Use Material 3 design system
      useMaterial3: true,

      // Color scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        onPrimary: Colors.white,
        secondary: AppColors.primaryColor,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: AppColors.textColor,
        error: Colors.red,
        onError: Colors.white,
      ),

      // Scaffold background
      scaffoldBackgroundColor: Colors.white,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textColor,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.strokeColor,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: AppTextTheme.titleLarge,
        toolbarTextStyle: AppTextTheme.bodyMedium,
        iconTheme: const IconThemeData(
          color: AppColors.textColor,
        ),
      ),

      // Text theme
      textTheme: AppTextTheme.getTextTheme(),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          textStyle: AppTextTheme.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL.w,
            vertical: AppDimensions.paddingM.h,
          ),
          minimumSize: Size(double.infinity, AppDimensions.buttonHeight.h),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: AppTextTheme.button.copyWith(
            color: AppColors.primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL.w,
            vertical: AppDimensions.paddingS.h,
          ),
          minimumSize: Size(double.infinity, AppDimensions.buttonHeight.h),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          textStyle: AppTextTheme.button.copyWith(
            color: AppColors.primaryColor,
          ),
          side: const BorderSide(
            color: AppColors.strokeColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingL.w,
            vertical: AppDimensions.paddingM.h,
          ),
          minimumSize: Size(double.infinity, AppDimensions.buttonHeight.h),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.textFieldColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL.r),
          borderSide: const BorderSide(
            color: AppColors.strokeColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL.r),
          borderSide: const BorderSide(
            color: AppColors.strokeColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL.r),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        hintStyle: AppTextTheme.bodyMedium.copyWith(
          color: AppColors.textColor2,
        ),
        labelStyle: AppTextTheme.bodyMedium,
        errorStyle: AppTextTheme.bodySmall.copyWith(
          color: Colors.red,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL.w,
          vertical: AppDimensions.paddingM.h,
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL.r),
          side: const BorderSide(
            color: AppColors.strokeColor,
            width: 1,
          ),
        ),
        margin: EdgeInsets.all(AppDimensions.paddingS.r),
      ),

      // Divider theme
      dividerTheme: const DividerThemeData(
        color: AppColors.strokeColor,
        thickness: 1,
        space: 1,
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textColor,
        size: 24,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.textColor2,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: const BorderSide(
          color: AppColors.strokeColor,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS.r),
        ),
      ),

      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.strokeColor;
        }),
      ),

      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.strokeColor;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor.withAlpha(77);
          }
          return AppColors.strokeColor.withAlpha(77);
        }),
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        linearTrackColor: AppColors.strokeColor,
        circularTrackColor: AppColors.strokeColor,
      ),

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textColor,
        contentTextStyle: AppTextTheme.bodyMedium.copyWith(
          color: Colors.white,
        ),
        actionTextColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL.r),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Tab bar theme
      tabBarTheme: TabBarTheme(
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.textColor2,
        labelStyle: AppTextTheme.labelLarge,
        unselectedLabelStyle: AppTextTheme.labelLarge,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
