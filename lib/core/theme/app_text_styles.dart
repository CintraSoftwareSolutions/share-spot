import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_fonts.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  /// Wait & Dine styles explicitly opt out of inherited text decorations.
  ///
  /// Keeping these styles as shared tokens prevents a decorated parent theme
  /// (for example, a link style) from adding a line to offer-card labels.
  static const TextStyle waitAndDineTitle = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1.15,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    decorationColor: AppColors.transparent,
  );

  static const TextStyle diningOfferTitle = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1.15,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    decorationColor: AppColors.transparent,
  );

  static const TextStyle diningOfferDiscount = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.authLink,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1.15,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    decorationColor: AppColors.transparent,
  );

  static const TextStyle diningOfferMeta = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.textSecondary,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontVariations: [FontVariation('wght', 500)],
    height: 1.15,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    decorationColor: AppColors.transparent,
  );

  static const TextStyle diningOfferTag = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.background,
    fontSize: 8,
    fontWeight: FontWeight.w700,
    fontVariations: [FontVariation('wght', 700)],
    height: 1.15,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    decorationColor: AppColors.transparent,
  );

  static const TextStyle dialogTitle = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1,
  );

  static const TextStyle dialogBody = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontVariations: [FontVariation('wght', 500)],
    height: 1.35,
  );

  static const TextStyle buttonLabel = AppTextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1,
  );

  static const TextStyle authButtonLabel = AppTextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontVariations: [FontVariation('wght', 700)],
    height: 1.2,
    letterSpacing: 0,
  );

  static const TextStyle authInlineButtonLabel = AppTextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1.15,
    letterSpacing: 0,
  );

  static const TextStyle rewardActivityMeta = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontVariations: [FontVariation('wght', 500)],
    height: 1,
    letterSpacing: 0,
  );

  static const TextStyle rewardCardText = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontVariations: [FontVariation('wght', 500)],
    height: 1,
    letterSpacing: 0,
  );

  static const TextStyle communityReview = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    fontVariations: [FontVariation('wght', 500)],
    height: 1,
    letterSpacing: 0,
  );

  static const TextStyle activityMeta = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.hexFFBECAB7,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontVariations: [FontVariation('wght', 500)],
    height: 1,
    letterSpacing: 0,
  );

  static const TextStyle subheading = AppTextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1,
    letterSpacing: 0,
  );

  /// Notification list typography is kept explicit so route/theme changes
  /// cannot accidentally add links or debug-looking text decoration.
  static const TextStyle notificationTitle = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontVariations: [FontVariation('wght', 600)],
    height: 1.2,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    decorationColor: AppColors.transparent,
  );

  static const TextStyle notificationBody = AppTextStyle(
    fontFamily: AppFonts.primary,
    color: AppColors.textMuted,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontVariations: [FontVariation('wght', 500)],
    height: 1.2,
    letterSpacing: 0,
    decoration: TextDecoration.none,
    decorationColor: AppColors.transparent,
  );

  static const TextStyle display = AppTextStyle(
    fontFamily: AppFonts.primary,
    fontSize: 37,
    fontWeight: FontWeight.w700,
    fontVariations: [FontVariation('wght', 700)],
    height: 1,
    letterSpacing: 0,
  );

  static const TextStyle heading = AppTextStyle(
    fontFamily: AppFonts.brand,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    fontVariations: [FontVariation('wght', 700)],
    height: 1,
    letterSpacing: 0,
  );
}

/// General Sans base for one-off component styles.
/// Shared typography should use the named [AppTextStyles] tokens above.
class AppTextStyle extends TextStyle {
  const AppTextStyle({
    super.inherit = true,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.fontVariations,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamily = AppFonts.primary,
    super.fontFamilyFallback,
    super.package,
    super.overflow,
  });
}
