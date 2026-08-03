import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/activity/models/dining_offer.dart';
import 'package:sharespot/features/shared/activity/widgets/dining_offer_card.dart';

class WaitAndDineView extends StatelessWidget {
  const WaitAndDineView({super.key, this.showBack = false});

  final bool showBack;

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
    DiningOffer(
      image: AppImages.bellaItallino,
      name: 'Beachfront Escape',
      points: '4x Points',
      distance: '1.2 miles',
      discount: '30% Off',
      tag: 'Seasonal Special',
    ),
    DiningOffer(
      image: AppImages.tropicalParadise,
      name: 'The Night Kitchen',
      points: '2.5x Points',
      distance: '0.8 miles',
      discount: '10% Off',
      tag: 'Member Offer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.isMobile ? 20.0 : 32.0;
    final availableCardWidth = context.screenWidth - (horizontalPadding * 2);
    final scaledTextAllowance = ((context.textScale - 1).clamp(0.0, 1.0) * 24)
        .toDouble();
    final cardHeight =
        availableCardWidth.clamp(280.0, 400.0) * 0.55 + scaledTextAllowance;

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        maintainBottomViewPadding: true,
        minimum: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                22,
                horizontalPadding,
                18,
              ),
              child: Row(
                children: [
                  if (showBack) ...[
                    IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text('Wait & Dine', style: AppTextStyles.waitAndDineTitle),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  24,
                ),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: _offers.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) => RepaintBoundary(
                  key: ValueKey('wait-and-dine-offer-$index'),
                  child: SizedBox(
                    height: cardHeight,
                    child: DiningOfferCard(offer: _offers[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
