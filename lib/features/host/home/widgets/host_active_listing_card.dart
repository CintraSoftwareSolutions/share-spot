import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class HostActiveListingCard extends StatelessWidget {
  const HostActiveListingCard({required this.onManage, super.key});

  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Active Listing Card',
                  style: AppTextStyles.subheading.copyWith(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const Text(
                '96% Match Quality',
                style: AppTextStyle(
                  color: AppColors.textSoft,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderStrong),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage(AppImages.profile),
                    ),
                    const SizedBox(width: 11),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Central Mall Parking',
                            style: AppTextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '3 Drivers Interested',
                            style: AppTextStyle(
                              color: AppColors.textSoft,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.hexFF15331C,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Leaving in 8 min',
                        style: AppTextStyle(
                          color: AppColors.loginGreen,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: context.screenWidth,
                  height: 50,
                  child: FilledButton(
                    onPressed: onManage,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.loginGreen,
                      foregroundColor: AppColors.buttonInk,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Manage Listing  →',
                      style: AppTextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
