import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class NearbyParkingTile extends StatelessWidget {
  const NearbyParkingTile({
    required this.minutes,
    required this.match,
    required this.host,
    super.key,
  });

  final int minutes;
  final int match;
  final String host;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 12 : 16,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.hexFF173621,
              shape: BoxShape.circle,
            ),
            child: const Text(
              'P',
              style: AppTextStyle(
                color: AppColors.loginGreen,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$minutes min drive',
                  style: const AppTextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Leaving at 2:45 PM  •  Host: $host',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const AppTextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$match% Match',
            style: const AppTextStyle(
              color: AppColors.loginGreen,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
