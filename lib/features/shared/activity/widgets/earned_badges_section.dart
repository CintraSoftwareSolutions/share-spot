import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class EarnedBadgesSection extends StatelessWidget {
  const EarnedBadgesSection({
    this.badges = defaultBadges,
    this.firstProgressLabel = 'On-Time Arrival',
    this.firstProgressValue = '98%',
    this.secondProgressLabel = 'Swap Success',
    this.secondProgressValue = '94%',
    super.key,
  });

  final List<(String, String)> badges;
  final String firstProgressLabel;
  final String firstProgressValue;
  final String secondProgressLabel;
  final String secondProgressValue;

  static const defaultBadges = <(String, String)>[
    (AppImages.trustedDriver, 'Trusted Driver'),
    (AppImages.fastResponder, 'Fast Responder'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earned Badges',
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: badges
                .map((badge) => _BadgeChip(asset: badge.$1, label: badge.$2))
                .toList(growable: false),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _ProgressCard(
                  label: firstProgressLabel,
                  valueLabel: firstProgressValue,
                  value: 0.98,
                  color: AppColors.loginGreen,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _ProgressCard(
                  label: secondProgressLabel,
                  valueLabel: secondProgressValue,
                  value: 0.94,
                  color: AppColors.authLink,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.asset, required this.label});

  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.hexFF3A3D43),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 14,
            height: 14,
            child: Center(
              child: SvgPicture.asset(
                asset,
                width: 11,
                height: 14,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const AppTextStyle(color: AppColors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.label,
    required this.valueLabel,
    required this.value,
    required this.color,
  });

  final String label;
  final String valueLabel;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const AppTextStyle(
                    color: AppColors.hexFFCBCCD0,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(valueLabel, style: AppTextStyle(color: color, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 13),
          LinearProgressIndicator(
            value: value,
            minHeight: 6,
            color: color,
            backgroundColor: AppColors.hexFF30333A,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
