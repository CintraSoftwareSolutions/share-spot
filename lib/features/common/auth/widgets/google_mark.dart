import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class GoogleMark extends StatelessWidget {
  const GoogleMark({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: AppTextStyle(
        color: AppColors.hexFF4285F4,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
