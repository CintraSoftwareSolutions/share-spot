import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class RewardsBalanceCard extends StatelessWidget {
  const RewardsBalanceCard({
    required this.onRedeem,
    super.key,
    this.pointsLabel = 'Available Points',
    this.points = '2,450',
    this.savingsLabel = 'Est. Savings',
    this.savings = r'$120',
    this.tier = 'Silver Tier',
    this.nextTier = '550 pts to Gold',
    this.progress = 0.78,
  });

  final VoidCallback onRedeem;
  final String pointsLabel;
  final String points;
  final String savingsLabel;
  final String savings;
  final String tier;
  final String nextTier;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderStrong),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            AppColors.hexFF30294D,
            AppColors.hexFF242033,
            AppColors.surfaceElevated,
            AppColors.hexFF243026,
            AppColors.hexFF2C482E,
          ],
          stops: [0, 0.34, 0.5, 0.66, 1],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.hexFF87FC7D.withValues(alpha: 0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _BalanceValue(
                  label: pointsLabel,
                  value: points,
                  valueColor: AppColors.loginGreen,
                ),
              ),
              _BalanceValue(
                label: savingsLabel,
                value: savings,
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Expanded(
                child: Text(
                  tier,
                  style: const AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                nextTier,
                style: const AppTextStyle(
                  color: AppColors.loginGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            color: AppColors.loginGreen,
            backgroundColor: AppColors.hexFFE7E8E9,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton.icon(
              onPressed: onRedeem,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.loginGreen,
                foregroundColor: AppColors.greenInk,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: SvgPicture.asset(
                AppImages.redeemRewards,
                width: 17,
                height: 16,
              ),
              label: const Text(
                'Redeem Rewards',
                style: AppTextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceValue extends StatelessWidget {
  const _BalanceValue({
    required this.label,
    required this.value,
    this.valueColor = AppColors.white,
    this.textAlign = TextAlign.left,
  });

  final String label;
  final String value;
  final Color valueColor;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.right
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: textAlign,
          style: const AppTextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          textAlign: textAlign,
          style: AppTextStyle(
            color: valueColor,
            fontSize: 25,
            height: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
