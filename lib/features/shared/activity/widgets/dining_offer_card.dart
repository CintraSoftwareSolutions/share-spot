import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/activity/models/dining_offer.dart';

class DiningOfferCard extends StatelessWidget {
  const DiningOfferCard({required this.offer, super.key, this.compact = false});

  final DiningOffer offer;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(compact ? 14 : 12);
    final tagColor = offer.tag.toLowerCase().contains('free')
        ? AppColors.authLink
        : AppColors.loginGreen;

    return Semantics(
      container: true,
      label:
          '${offer.name}, ${offer.discount}, ${offer.points}, ${offer.distance}',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.authField,
          borderRadius: radius,
          border: Border.all(color: AppColors.authBorder),
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      offer.image,
                      fit: BoxFit.cover,
                      cacheWidth: context.isMobile ? 720 : 1080,
                      errorBuilder: (_, _, _) => const ColoredBox(
                        color: AppColors.authBorder,
                        child: Icon(Icons.restaurant, color: AppColors.white54),
                      ),
                    ),
                    Positioned(
                      left: compact ? 14 : 9,
                      bottom: compact ? 10 : 8,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: tagColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: compact ? 9 : 7,
                            vertical: compact ? 5 : 4,
                          ),
                          child: Text(
                            offer.tag.toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.diningOfferTag.copyWith(
                              fontSize: compact ? 9 : 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  compact ? 14 : 11,
                  compact ? 12 : 9,
                  compact ? 14 : 11,
                  compact ? 12 : 9,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            offer.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.diningOfferTitle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            offer.discount,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: AppTextStyles.diningOfferDiscount.copyWith(
                              fontSize: compact ? 13 : 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: compact ? 9 : 6),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.points,
                          width: compact ? 14 : 12,
                          height: compact ? 12 : 10,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          offer.points,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.diningOfferMeta.copyWith(
                            fontSize: compact ? 12 : 10,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9),
                          child: CircleAvatar(
                            radius: 2,
                            backgroundColor: AppColors.textSecondary,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            offer.distance,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.diningOfferMeta.copyWith(
                              fontSize: compact ? 12 : 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
