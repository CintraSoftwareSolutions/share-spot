import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_constants.dart';

extension Builddd on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  double get screenHeight => size.height;

  double get screenWidth => size.width;

  EdgeInsets get safeAreaPadding => MediaQuery.viewPaddingOf(this);

  double get bottomSafeArea => safeAreaPadding.bottom;

  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;

  double get textScale => MediaQuery.textScalerOf(this).scale(1);

  /// Height for full-width authentication actions.
  ///
  /// The extra room follows the user's text scale without making the fixed
  /// onboarding layouts unnecessarily tall at the default scale.
  double get authButtonHeight {
    final baseHeight = isCompactHeight ? 44.0 : 56.0;
    if (isCompactHeight) return baseHeight;
    final extraHeight = ((textScale - 1) * 16).clamp(0.0, 8.0).toDouble();
    return baseHeight + extraHeight;
  }

  /// Height for compact actions embedded in an authentication tile.
  double get authInlineButtonHeight {
    if (isCompactHeight) return 38;
    final extraHeight = ((textScale - 1) * 16).clamp(0.0, 8.0).toDouble();
    return 46 + extraHeight;
  }

  /// Width reserved for labels such as "Allow Access" at larger text sizes.
  double get authInlineButtonWidth {
    final extraWidth = ((textScale - 1) * 48).clamp(0.0, 20.0).toDouble();
    final baseWidth = isCompactHeight ? 104.0 : 124.0;
    return baseWidth + extraWidth;
  }

  bool get isKeyboardVisible => keyboardHeight > 0;

  bool get isCompactHeight => screenHeight < 720;

  double get safeBottomSpacing => bottomSafeArea + 16;

  bool get isMobile => screenWidth < AppConstants.mobileBreakpoint;

  bool get isTablet =>
      screenWidth >= AppConstants.mobileBreakpoint &&
      screenWidth < AppConstants.tabletBreakpoint;

  bool get isDesktop => screenWidth >= AppConstants.tabletBreakpoint;

  EdgeInsets get pagePadding => EdgeInsets.symmetric(
    horizontal: isMobile
        ? 16
        : isTablet
        ? 28
        : 40,
    vertical: isMobile ? 16 : 28,
  );

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colors => theme.colorScheme;
}
