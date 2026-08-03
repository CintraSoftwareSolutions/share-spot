import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class RewardTierProgress extends StatelessWidget {
  const RewardTierProgress({super.key, this.labelSuffix = ''});

  final String labelSuffix;

  @override
  Widget build(BuildContext context) {
    const tiers = [
      (AppImages.bronzeReward, 'Bronze', AppColors.hexFFCD7F32, true),
      (AppImages.silverReward, 'Silver', AppColors.loginGreen, true),
      (AppImages.bronzeReward, 'Gold', AppColors.hexFFB8A600, false),
      (AppImages.bronzeReward, 'Platinum', AppColors.hexFF74777E, false),
    ];

    return SizedBox(
      width: context.screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < tiers.length; index++) ...[
            Expanded(
              child: _Tier(
                asset: tiers[index].$1,
                label: '${tiers[index].$2}$labelSuffix',
                color: tiers[index].$3,
                active: tiers[index].$4,
              ),
            ),
            if (index < tiers.length - 1)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 22),
                  height: 2,
                  color: AppColors.hexFF34363B,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _Tier extends StatelessWidget {
  const _Tier({
    required this.asset,
    required this.label,
    required this.color,
    required this.active,
  });

  final String asset;
  final String label;
  final Color color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderStrong),
          ),
          child: Center(
            child: SvgPicture.asset(
              asset,
              width: 16,
              height: 21,
              colorFilter: active
                  ? null
                  : ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(height: 9),
        Text(
          label,
          style: AppTextStyle(
            color: active ? color : AppColors.hexFF74777E,
            fontSize: 10.5,
            fontWeight: label == 'Silver' ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
