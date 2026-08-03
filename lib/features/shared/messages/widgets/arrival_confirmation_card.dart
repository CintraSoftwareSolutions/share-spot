import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class ArrivalConfirmationCard extends StatelessWidget {
  const ArrivalConfirmationCard({required this.onConfirm, super.key});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.hexFF151A17,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.loginGreen),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.hexFF1B4525,
                child: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.loginGreen,
                  size: 19,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Almost Reached the location',
                      style: AppTextStyle(
                        color: AppColors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Waiting at Harbor Plaza.',
                      style: AppTextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: onConfirm,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.loginGreen,
                foregroundColor: AppColors.authSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text(
                'Confirm Your Arrival',
                style: AppTextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
