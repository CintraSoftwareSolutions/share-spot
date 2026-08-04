import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class ActivitySummaryCard extends StatelessWidget {
  const ActivitySummaryCard({
    this.points = '2,450',
    this.stats = defaultStats,
    super.key,
  });

  final String points;
  final List<(String, String)> stats;

  static const defaultStats = <(String, String)>[
    ('Parking\nExchanges', '124'),
    ('Active\nSwaps', '12'),
    ('Response\nTime', '2 Mins'),
    ('Rating', '4.8'),
    ('Success', '96%'),
    ('Level', 'Elite Tier'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.hexFF87FC7D.withValues(alpha: 0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderStrong),
            ),
            child: Stack(
              children: [
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topRight,
                        radius: 1.05,
                        colors: [AppColors.hex4D87FC7D, AppColors.transparent],
                        stops: [0, 0.72],
                      ),
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.bottomLeft,
                        radius: 0.9,
                        colors: [AppColors.hex4D907EF2, AppColors.transparent],
                        stops: [0, 0.68],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total Rewards',
                                  style: AppTextStyle(
                                    color: AppColors.hexFFD5D6DA,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      points,
                                      style: AppTextStyle(
                                        color: AppColors.loginGreen,
                                        fontSize: 30,
                                        height: 1,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: Text(
                                        'PTS',
                                        style: AppTextStyle(
                                          color: AppColors.loginGreen,
                                          fontSize: 14,
                                          height: 1,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.loginGreen.withValues(
                                alpha: 0.18,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppImages.rewards,
                                width: 14,
                                height: 14,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 90,
                            ),
                        itemCount: stats.length,
                        itemBuilder: (context, index) {
                          final stat = stats[index];
                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stat.$1,
                                  maxLines: 2,
                                  style: AppTextStyles.activityMeta,
                                ),
                                const SizedBox(height: 7),
                                if (stat.$1 == 'Rating')
                                  Row(
                                    children: [
                                      Text(
                                        stat.$2,
                                        style: const AppTextStyle(
                                          color: AppColors.hexFFE3E3E7,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Icon(
                                        Icons.star_rounded,
                                        color: AppColors.loginGreen,
                                        size: 15,
                                      ),
                                    ],
                                  )
                                else
                                  Text(
                                    stat.$2,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const AppTextStyle(
                                      color: AppColors.hexFFE3E3E7,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
