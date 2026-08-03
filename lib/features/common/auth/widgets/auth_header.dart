import 'package:flutter/material.dart';
import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/theme/app_colors.dart';

import 'package:sharespot/core/theme/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.height,
    super.key,
    this.alignment = Alignment.center,
  });

  final double height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: SafeArea(
        bottom: false,
        child: Align(
          alignment: alignment,
          child: Text(
            AppConstants.appName,
            style: AppTextStyles.heading.copyWith(
              color: AppColors.white,
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}
