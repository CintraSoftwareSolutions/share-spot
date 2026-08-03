import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/guest/home/providers/parking_insights_provider.dart';

class DestinationPreferenceCard extends StatelessWidget {
  const DestinationPreferenceCard({
    required this.destinationName,
    required this.arrivalTime,
    super.key,
  });

  final String destinationName;
  final String arrivalTime;

  @override
  Widget build(BuildContext context) {
    final isPrimary = context.select<ParkingInsightsProvider, bool>(
      (provider) => provider.isPrimaryDestination,
    );

    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.borderStrong),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  destinationName,
                  style: const AppTextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.authLink,
                size: 17,
              ),
              const SizedBox(width: 7),
              Text(
                arrivalTime,
                style: const AppTextStyle(
                  color: AppColors.hexFFD4D5D8,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          const Divider(color: AppColors.hexFF303238, height: 1),
          const SizedBox(height: 11),
          Row(
            children: [
              const Icon(
                Icons.verified_outlined,
                color: AppColors.loginGreen,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Set as Primary Destination',
                  style: AppTextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 42,
                height: 30,
                child: Transform.scale(
                  scale: 0.72,
                  child: Switch.adaptive(
                    value: isPrimary,
                    onChanged: context
                        .read<ParkingInsightsProvider>()
                        .setPrimaryDestination,
                    activeTrackColor: AppColors.loginGreen,
                    activeThumbColor: AppColors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
