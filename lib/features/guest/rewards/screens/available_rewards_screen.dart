import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/rewards/widgets/reward_offer_card.dart';

class AvailableRewardsScreen extends StatelessWidget {
  const AvailableRewardsScreen({super.key});

  static const _rewards = [
    (AppImages.tropicalParadise, '50% Off First Drink', 'The Velvet Room', 800),
    (AppImages.bellaItallino, 'Buy One Get One Free', 'Café Delights', 500),
    (
      AppImages.tropicalParadise,
      'Free Coffee with Any Sandwich',
      'Bistro Café',
      400,
    ),
    (AppImages.bellaItallino, '30% Off Your Dinner', 'Verona Italian', 650),
  ];

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.isMobile ? 8 : 20,
                10,
                padding,
                12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    tooltip: 'Back',
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      'Available Rewards',
                      style: AppTextStyles.subheading.copyWith(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(padding, 0, padding, 28),
                itemCount: _rewards.length,
                separatorBuilder: (_, _) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  final reward = _rewards[index];
                  return RewardOfferCard(
                    image: reward.$1,
                    title: reward.$2,
                    venue: reward.$3,
                    points: reward.$4,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
