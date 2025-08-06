import 'package:easy_localization/easy_localization.dart' as loc;
import 'package:flutter/material.dart';
import 'package:oivan_task/core/constants/app_dimensions.dart';

/// *** Extensions on BuildContext class *** ----------------
extension BuildContextUtils on BuildContext {
  //* MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  //* Dimensions Extensions
  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  Size get screenSize => MediaQuery.of(this).size;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get shortestSide => MediaQuery.of(this).size.shortestSide;

  double get longestSide => MediaQuery.of(this).size.longestSide;

  Orientation get orientation => MediaQuery.of(this).orientation;

  double heightR(double value) => MediaQuery.of(this).size.height * value;

  double widthR(double value) => MediaQuery.of(this).size.width * value;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  //* Device Breakpoints

  bool get isMobile => isPortrait
      ? width <= AppDimensions.mobileBreakpoint
      : height <= AppDimensions.mobileBreakpoint;

  bool get isTablet =>
      MediaQuery.of(this).size.width >= AppDimensions.tabletBreakpoint;

  bool get isLargeMobile =>
      isMobile && height > AppDimensions.largeMobileBreakpoint;

  bool get isSmallMobile =>
      isMobile && height < AppDimensions.smallMobileBreakpoint;

  TextDirection get textDirection => Directionality.of(this);

  Key get localeKey => ValueKey(locale);

  //* Theme Extensions
  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void closeKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}

extension Sliver on Widget {
  Widget get sliver {
    return SliverToBoxAdapter(
      child: this,
    );
  }
}
