import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class BestMatchCard extends StatelessWidget {
  const BestMatchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sarah Wilson',
                      style: AppTextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '⭐ 4.9  •  300m away',
                      style: AppTextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.hexFF173621,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Leaving in 4 min',
                  style: AppTextStyle(
                    color: AppColors.loginGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 332),
              child: SizedBox(
                width: double.infinity,
                height: 43,
                child: FilledButton.icon(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.loginGreen,
                    foregroundColor: AppColors.background,
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  label: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Reserve Spot',
                      maxLines: 1,
                      softWrap: false,
                      style: AppTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
