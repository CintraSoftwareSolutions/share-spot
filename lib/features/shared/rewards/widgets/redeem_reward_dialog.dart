import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class RedeemRewardDialog extends StatelessWidget {
  const RedeemRewardDialog({
    super.key,
    this.iconAsset = AppImages.redeemRewards,
  });

  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 24 : 40,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 390),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.borderStrong),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppColors.hexFFE9FBE9,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(iconAsset, width: 26, height: 26),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    tooltip: 'Close',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textSoft,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text('Redeem Reward?', style: AppTextStyles.dialogTitle),
              const SizedBox(height: 16),
              const Text.rich(
                TextSpan(
                  style: AppTextStyles.dialogBody,
                  children: [
                    TextSpan(text: "You're about to redeem 500 Points for a "),
                    TextSpan(
                      text: '20% Off Voucher',
                      style: AppTextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text:
                          ' at Bella Italia.\nThis reward will be added to your wallet and can be used during checkout.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reward added to your wallet.'),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.loginGreen,
                    foregroundColor: AppColors.greenInk,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Redeem Reward',
                    style: AppTextStyles.buttonLabel,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.borderStrong),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text('Cancel', style: AppTextStyles.buttonLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
