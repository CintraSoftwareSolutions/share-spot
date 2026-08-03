import 'package:flutter/material.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class RewardOfferCard extends StatelessWidget {
  const RewardOfferCard({
    required this.image,
    required this.title,
    required this.venue,
    required this.points,
    super.key,
  });

  final String image;
  final String title;
  final String venue;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: (context.screenWidth * 0.45).clamp(168.0, 210.0),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 11, 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.rewardCardText),
                      const SizedBox(height: 6),
                      Text(
                        "At '$venue'",
                        style: AppTextStyles.rewardCardText.copyWith(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 43,
                    minHeight: 48,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDeep,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$points',
                        style: const AppTextStyle(
                          color: AppColors.loginGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'POINTS',
                        style: AppTextStyle(
                          color: AppColors.iconLight,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
