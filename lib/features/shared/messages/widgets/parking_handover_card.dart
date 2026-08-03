import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class ParkingHandoverCard extends StatelessWidget {
  const ParkingHandoverCard({super.key, this.isCompleted = false});

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 39,
            height: 39,
            decoration: const BoxDecoration(
              color: AppColors.hexFF15341F,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.directions_car_filled_rounded,
              color: AppColors.loginGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tesla Model 3 • Midnight Silver',
                  style: AppTextStyle(
                    color: AppColors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'ABC-1234 • 96% Reliability',
                  style: AppTextStyle(color: AppColors.textMuted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isCompleted ? 'Exchange' : 'Reaching in',
                style: const AppTextStyle(
                  color: AppColors.loginGreen,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 3),
              Text(
                isCompleted ? 'Completed' : '4 mins',
                style: const AppTextStyle(
                  color: AppColors.white,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
