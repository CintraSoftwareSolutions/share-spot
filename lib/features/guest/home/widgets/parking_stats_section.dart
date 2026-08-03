import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class ParkingStatsSection extends StatelessWidget {
  const ParkingStatsSection({required this.successRate, super.key});

  final String successRate;

  static const _bars = [
    0.35,
    0.48,
    0.62,
    0.86,
    0.74,
    0.58,
    0.42,
    0.31,
    0.46,
    0.62,
    0.40,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Parking Stats',
            style: AppTextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Success Rate',
                  value: successRate,
                  color: AppColors.loginGreen,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: _StatCard(
                  label: 'Avg. Wait Time',
                  value: '4 mins',
                  color: AppColors.hexFF4CA0FF,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.fromLTRB(13, 13, 13, 11),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderStrong),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Historical Availability',
                        style: AppTextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Peak: 12PM',
                      style: AppTextStyle(
                        color: AppColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 42,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var index = 0; index < _bars.length; index++)
                        Expanded(
                          child: Container(
                            height: 42 * _bars[index],
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            color: index >= 3 && index <= 5
                                ? AppColors.loginGreen.withValues(
                                    alpha: index == 3 ? 0.65 : 1,
                                  )
                                : AppColors.hexFF2C2E34,
                          ),
                        ),
                    ],
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 88),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const AppTextStyle(color: AppColors.textSoft, fontSize: 11),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
