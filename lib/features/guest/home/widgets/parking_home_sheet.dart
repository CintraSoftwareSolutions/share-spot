import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/activity/models/dining_offer.dart';
import 'package:sharespot/features/shared/activity/widgets/dining_offer_card.dart';
import 'best_match_card.dart';
import 'nearby_parking_tile.dart';

class ParkingHomeSheet extends StatelessWidget {
  const ParkingHomeSheet({
    required this.scrollController,
    required this.onViewAll,
    super.key,
  });

  final ScrollController scrollController;
  final VoidCallback onViewAll;

  static const _offers = [
    DiningOffer(
      image: AppImages.bellaItallino,
      name: 'Bella Italia',
      points: '2x Points',
      distance: '0.4 miles',
      discount: '20% Off',
      tag: 'Exclusive Offer',
    ),
    DiningOffer(
      image: AppImages.tropicalParadise,
      name: 'Tropical Paradise',
      points: '1.5x Points',
      distance: '0.3 miles',
      discount: '15% Off',
      tag: 'Free Drink',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.isMobile ? 16.0 : 28.0;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          12,
          horizontalPadding,
          28,
        ),
        children: [
          Center(
            child: Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.hexFF555861,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Best Match  ✦',
                  style: AppTextStyles.subheading.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              const Text(
                '96% Reliability',
                style: AppTextStyle(color: AppColors.textMuted, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const BestMatchCard(),
          const SizedBox(height: 24),
          Text(
            'Available Nearby',
            style: AppTextStyles.subheading.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 13),
          const NearbyParkingTile(minutes: 10, match: 92, host: 'John D.'),
          const NearbyParkingTile(minutes: 2, match: 88, host: 'Mike R.'),
          const NearbyParkingTile(minutes: 5, match: 75, host: 'Sarah L.'),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Wait & Dine',
                  style: AppTextStyles.subheading.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.loginGreen,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(56, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: AppTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 188,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _offers.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) => SizedBox(
                width: context.screenWidth * 0.56,
                child: DiningOfferCard(offer: _offers[index], compact: true),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
