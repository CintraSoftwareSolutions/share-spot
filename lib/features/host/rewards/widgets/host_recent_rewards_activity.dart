import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class HostRecentRewardsActivity extends StatelessWidget {
  const HostRecentRewardsActivity({super.key, this.showAll = false});

  final bool showAll;

  static const _preview = [
    (
      AppImages.successfulSwap,
      'Spot Shared Successfully',
      'Oct 24 • Urban Outfitters',
      '+50 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.wroteReview,
      'Guest Assisted',
      'Oct 22 • Bistro Lumière',
      '+25 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.rewards,
      'High Host Rating Earned',
      'Oct 21 • 98% Reliability',
      '+25 Pts',
      AppColors.loginGreen,
    ),
  ];

  static const _all = [
    (
      AppImages.successfulSwap,
      'Shared Parking Spot',
      'Oct 24 • Central Mall',
      '+60 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.successfulSwap,
      'Successful Swap',
      'Oct 23 • Downtown Plaza',
      '+50 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.redeemedReward,
      'Redeemed Fuel Voucher',
      'Oct 22 • Fuel Rewards',
      '-400 Pts',
      AppColors.error,
    ),
    (
      AppImages.rewards,
      '5-Star Host Rating',
      'Oct 21 • Community Review',
      '+40 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.successfulSwap,
      'Shared Parking Spot',
      'Oct 19 • Harbor Center',
      '+30 Pts',
      AppColors.loginGreen,
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
      'Fast Response Bonus',
      'Oct 18 • Under 1 Minute Response',
      '+20 Pts',
      AppColors.loginGreen,
    ),
    (
      AppImages.redeemedReward,
      'Car Wash Voucher',
      'Oct 17 • Premium Car Wash',
      '-800 Pts',
      AppColors.error,
    ),
    (
      AppImages.successfulSwap,
      'Weekly Hosting Streak',
      'Oct 16 • 7-Day Active',
      '+100 Pts',
      AppColors.loginGreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activities = showAll ? _all : _preview;
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
                color: AppColors.surface,
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
                        height: 15,
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const AppTextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          activities[index].$3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.rewardActivityMeta.copyWith(
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    activities[index].$4,
                    style: AppTextStyle(
                      color: activities[index].$5,
                      fontSize: 12,
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
