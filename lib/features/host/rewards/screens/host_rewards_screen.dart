import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/rewards/widgets/invite_and_earn_card.dart';
import 'package:sharespot/features/shared/rewards/widgets/redeem_reward_dialog.dart';
import 'package:sharespot/features/shared/rewards/widgets/reward_offer_card.dart';
import 'package:sharespot/features/shared/rewards/widgets/reward_tier_progress.dart';
import 'package:sharespot/features/shared/rewards/widgets/rewards_balance_card.dart';
import 'package:sharespot/features/host/rewards/widgets/host_perks_section.dart';
import 'package:sharespot/features/host/rewards/widgets/host_recent_rewards_activity.dart';

class HostRewardsScreen extends StatelessWidget {
  const HostRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            padding,
            22,
            padding,
            28 + context.bottomSafeArea,
          ),
          children: [
            Text(
              'Rewards',
              style: AppTextStyles.subheading.copyWith(
                color: AppColors.white,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 22),
            RewardsBalanceCard(
              pointsLabel: 'Host Points',
              points: '3,250',
              savingsLabel: 'Estimated Savings',
              savings: r'$160',
              tier: 'Silver Tier',
              nextTier: '550 pts to Gold',
              progress: 0.8,
              onRedeem: () => showDialog<bool>(
                context: context,
                barrierColor: AppColors.black.withValues(alpha: 0.78),
                builder: (_) => const RedeemRewardDialog(
                  iconAsset: AppImages.hostRedeemRewards,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const RewardTierProgress(labelSuffix: ' Host'),
            const SizedBox(height: 26),
            _HostSectionHeader(
              title: 'Available Rewards',
              action: 'View all',
              onAction: () => Navigator.pushNamed(
                context,
                AppRouteNames.hostAvailableRewards,
              ),
            ),
            const SizedBox(height: 14),
            const RewardOfferCard(
              image: AppImages.tropicalParadise,
              title: '50% Off First Drink',
              venue: 'The Velvet Room',
              points: 800,
            ),
            const SizedBox(height: 14),
            const RewardOfferCard(
              image: AppImages.bellaItallino,
              title: 'Buy One Get One Free',
              venue: 'Café Delights',
              points: 500,
            ),
            const SizedBox(height: 26),
            const _HostSectionHeader(title: 'Host Perks'),
            const SizedBox(height: 13),
            const HostPerksSection(),
            const SizedBox(height: 26),
            _HostSectionHeader(
              title: 'Recent Activity',
              action: 'View all',
              onAction: () => Navigator.pushNamed(
                context,
                AppRouteNames.hostRecentRewardsActivity,
              ),
            ),
            const SizedBox(height: 13),
            const HostRecentRewardsActivity(),
            const SizedBox(height: 26),
            InviteAndEarnCard(
              onRefer: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Referral link ready to share.')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HostSectionHeader extends StatelessWidget {
  const _HostSectionHeader({required this.title, this.action, this.onAction});

  final String title;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.white,
              fontSize: 14,
            ),
          ),
        ),
        if (action != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.loginGreen,
              minimumSize: Size.zero,
              padding: const EdgeInsets.symmetric(vertical: 4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              action!,
              style: const AppTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
