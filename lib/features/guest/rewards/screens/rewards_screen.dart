import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/rewards/widgets/invite_and_earn_card.dart';
import 'package:sharespot/features/shared/rewards/widgets/partner_spots_section.dart';
import 'package:sharespot/features/shared/rewards/widgets/recent_rewards_activity.dart';
import 'package:sharespot/features/shared/rewards/widgets/redeem_reward_dialog.dart';
import 'package:sharespot/features/shared/rewards/widgets/reward_offer_card.dart';
import 'package:sharespot/features/shared/rewards/widgets/reward_tier_progress.dart';
import 'package:sharespot/features/shared/rewards/widgets/rewards_balance_card.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(padding, 22, padding, 30),
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
              onRedeem: () => showDialog<bool>(
                context: context,
                barrierColor: AppColors.black.withValues(alpha: 0.72),
                builder: (_) => const RedeemRewardDialog(),
              ),
            ),
            const SizedBox(height: 25),
            const RewardTierProgress(),
            const SizedBox(height: 27),
            _SectionHeader(
              title: 'Available Rewards',
              action: 'View all',
              onAction: () =>
                  Navigator.pushNamed(context, AppRouteNames.availableRewards),
            ),
            const SizedBox(height: 15),
            const RewardOfferCard(
              image: AppImages.tropicalParadise,
              title: '50% Off First Drink',
              venue: 'The Velvet Room',
              points: 800,
            ),
            const SizedBox(height: 15),
            const RewardOfferCard(
              image: AppImages.bellaItallino,
              title: 'Buy One Get One Free',
              venue: 'Café Delights',
              points: 500,
            ),
            const SizedBox(height: 27),
            const _SectionHeader(title: 'Partner Spots'),
            const SizedBox(height: 13),
            const PartnerSpotsSection(),
            const SizedBox(height: 27),
            _SectionHeader(
              title: 'Recent Activity',
              action: 'View all',
              onAction: () => Navigator.pushNamed(
                context,
                AppRouteNames.recentRewardsActivity,
              ),
            ),
            const SizedBox(height: 13),
            const RecentRewardsActivity(),
            const SizedBox(height: 27),
            InviteAndEarnCard(
              onRefer: () => _showMessage(
                context,
                'Your referral link is ready to share.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({this.title = '', this.action, this.onAction});

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
            child: Text(action!, style: const AppTextStyle(fontSize: 12)),
          ),
      ],
    );
  }
}
