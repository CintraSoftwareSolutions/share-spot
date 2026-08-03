import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';

import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';

class AuthSheetHeading extends StatelessWidget {
  const AuthSheetHeading({
    required this.title,
    required this.subtitle,
    super.key,
    this.subtitleFontSize = 13,
  });

  final String title;
  final String subtitle;
  final double subtitleFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.display.copyWith(
            color: AppColors.white,
            fontSize: 20,
          ),
        ),
        SizedBox(height: context.isCompactHeight ? 4 : 7),
        Text(
          subtitle,
          style: AppTextStyle(
            color: AppColors.textMuted,
            fontSize: subtitleFontSize,
            height: context.isCompactHeight ? 1.25 : 1.45,
          ),
        ),
      ],
    );
  }
}
