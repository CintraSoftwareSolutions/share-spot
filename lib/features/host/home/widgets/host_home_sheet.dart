import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/activity/models/dining_offer.dart';
import 'package:sharespot/features/shared/activity/widgets/dining_offer_card.dart';
import 'package:sharespot/features/host/home/models/incoming_host_request.dart';
import 'host_active_listing_card.dart';
import 'incoming_host_request_tile.dart';

class HostHomeSheet extends StatelessWidget {
  const HostHomeSheet({
    required this.scrollController,
    required this.onViewAll,
    super.key,
  });

  final ScrollController scrollController;
  final VoidCallback onViewAll;

  static const _requests = [
    IncomingHostRequest(
      name: 'Michael Carter',
      rating: '4.9',
      distance: '2 mins away',
      match: 92,
    ),
    IncomingHostRequest(
      name: 'Sarah Johnson',
      rating: '4.7',
      distance: '5 mins away',
      match: 85,
    ),
    IncomingHostRequest(
      name: 'David Smith',
      rating: '4.5',
      distance: '10 mins away',
      match: 78,
    ),
  ];

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
    final padding = context.isMobile ? 16.0 : 28.0;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.fromLTRB(padding, 12, padding, 28),
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
          const SizedBox(height: 18),
          HostActiveListingCard(
            onManage: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Opening listing manager...')),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'Incoming Requests',
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 13),
          for (final request in _requests)
            IncomingHostRequestTile(request: request),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Wait & Dine',
                  style: AppTextStyles.subheading.copyWith(
                    color: AppColors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: onViewAll,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.loginGreen,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(55, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: AppTextStyle(
                    fontSize: 13,
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
