import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class RecentRewardsActivity extends StatelessWidget {
  const RecentRewardsActivity({super.key, this.showAll = false});

  final bool showAll;

  static const _previewActivities = [
    (
      AppImages.successfulSwap,
      'Successful Swap',
      'Oct 24 • Urban Outfitters',
      '+50 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.wroteReview,
      'Wrote a Review',
      'Oct 22 • Bistro Lumière',
      '+25 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.redeemedReward,
      'Redeemed Reward',
      'Oct 19 • Amazon Gift Card',
      '-1,500 Pts',
      AppColors.error,
    ),
  ];

  static const _allActivities = [
    (
      AppImages.redeemedReward,
      'Redeemed Reward',
      'Oct 22 • Netflix Subscription',
      '-1,200 Pts',
      AppColors.error,
    ),
    (
      AppImages.successfulSwap,
      'Successful Swap',
      'Oct 24 • Urban Outfitters',
      '+50 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.successfulSwap,
      'Instant Redemption',
      'Oct 30 • Starbucks',
      '+30 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.redeemedReward,
      'Redeemed Reward',
      'Oct 21 • iTunes Gift Card',
      '-2,000 Pts',
      AppColors.error,
    ),
    (
      AppImages.successfulSwap,
      'Weekly Bonus',
      'Nov 1 • Amazon',
      '+20 Pts',
      AppColors.loginGreen,
    ),
    ..._previewActivities,
  ];

  @override
  Widget build(BuildContext context) {
    final activities = showAll ? _allActivities : _previewActivities;

    return SizedBox(
      width: context.screenWidth,
      child: Column(
        children: [
          for (var index = 0; index < activities.length; index++)
            Container(
              margin: EdgeInsets.only(
                bottom: index == activities.length - 1 ? 0 : 11,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
              decoration: BoxDecoration(
                color: AppColors.authField,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: AppColors.borderStrong),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.circleSurface,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        activities[index].$1,
                        width: 15,
                        height: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activities[index].$2,
                          style: const AppTextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          activities[index].$3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.rewardActivityMeta,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    activities[index].$4,
                    style: AppTextStyle(
                      color: activities[index].$5,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
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
