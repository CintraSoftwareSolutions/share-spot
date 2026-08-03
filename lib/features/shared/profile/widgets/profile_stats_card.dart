import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class ProfileStatsCard extends StatelessWidget {
  const ProfileStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderStrong),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            AppColors.surfaceElevated,
            AppColors.surfaceElevated,
            AppColors.hex302E6A39,
          ],
        ),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ProfileStat(
                  label: 'Community Rating',
                  value: '4.8',
                  trailing: Icon(
                    Icons.star_rounded,
                    color: AppColors.white,
                    size: 14,
                  ),
                ),
              ),
              Expanded(
                child: _ProfileStat(
                  label: 'Reliability',
                  value: '96%',
                  trailing: Icon(
                    Icons.verified_rounded,
                    color: AppColors.loginGreen,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _ProfileStat(label: 'Parking Exchanges', value: '124'),
              ),
              Expanded(
                child: _ProfileStat(
                  label: 'Reward Points',
                  value: '2,450',
                  valueColor: AppColors.loginGreen,
                  useRewardAsset: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({
    required this.label,
    required this.value,
    this.trailing,
    this.valueColor = AppColors.white,
    this.useRewardAsset = false,
  });

  final String label;
  final String value;
  final Widget? trailing;
  final Color valueColor;
  final bool useRewardAsset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const AppTextStyle(
            color: AppColors.textTertiary,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Text(
              value,
              style: AppTextStyle(
                color: valueColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            if (useRewardAsset)
              SvgPicture.asset(AppImages.profileReward, width: 14, height: 16)
            else
              trailing ?? const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
