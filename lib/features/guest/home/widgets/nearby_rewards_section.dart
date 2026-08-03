import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class NearbyRewardsSection extends StatelessWidget {
  const NearbyRewardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const rewards = [
      (AppImages.tropicalParadise, '50% Off First Drink', '800'),
      (AppImages.bellaItallino, 'Buy One Get One Free', '500'),
    ];
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nearby Rewards',
            style: AppTextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 205,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: rewards.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) => Container(
                width: context.screenWidth * 0.63,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        rewards[index].$1,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 9, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rewards[index].$2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const AppTextStyle(
                                    color: AppColors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  "At 'The Velvet Room'",
                                  style: AppTextStyle(
                                    color: AppColors.hexFFCACBD0,
                                    fontSize: 10.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDeep,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  rewards[index].$3,
                                  style: const AppTextStyle(
                                    color: AppColors.loginGreen,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'POINTS',
                                  style: AppTextStyle(
                                    color: AppColors.iconLight,
                                    fontSize: 7,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
