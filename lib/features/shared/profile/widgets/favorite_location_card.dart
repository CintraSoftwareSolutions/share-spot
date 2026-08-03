import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/profile/models/favorite_location.dart';

class FavoriteLocationCard extends StatelessWidget {
  const FavoriteLocationCard({
    required this.location,
    required this.onTap,
    super.key,
  });

  final FavoriteLocation location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          width: context.screenWidth,
          height: context.isMobile ? 218 : 260,
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderStrong),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: context.screenWidth,
                    child: Image.asset(location.image, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 11, 13, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              location.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const AppTextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              location.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const AppTextStyle(
                                color: AppColors.textTertiary,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 9),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.authLink,
                                  size: 15,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    location.arrivalTime,
                                    maxLines: 2,
                                    style: const AppTextStyle(
                                      color: AppColors.hexFFD5D6DA,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            location.reliability,
                            style: AppTextStyle(
                              color: location.isCritical
                                  ? AppColors.authLink
                                  : AppColors.loginGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            location.isCritical ? 'CRITICAL' : 'RESERVED',
                            style: AppTextStyle(
                              color: location.isCritical
                                  ? AppColors.hexFFFF315E
                                  : AppColors.loginGreen,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
