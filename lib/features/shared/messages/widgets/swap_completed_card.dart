import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class SwapCompletedCard extends StatelessWidget {
  const SwapCompletedCard({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.hexFF102418,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: context.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.hexFF1C5630),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: AppColors.loginGreen,
                child: Icon(
                  Icons.workspace_premium_outlined,
                  color: AppColors.authSurface,
                  size: 14,
                ),
              ),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Swap Completed! +50 Points earned.',
                  style: AppTextStyle(
                    color: AppColors.loginGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.loginGreen,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
