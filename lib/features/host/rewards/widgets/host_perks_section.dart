import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';

class HostPerksSection extends StatelessWidget {
  const HostPerksSection({super.key});

  @override
  Widget build(BuildContext context) {
    const perks = [
      (AppImages.priorityMatching, 'Priority Matching'),
      (AppImages.featuredListing, 'Featured Listing'),
      (AppImages.cafeRewards, 'Café Reward'),
    ];
    return SizedBox(
      width: context.screenWidth,
      child: Row(
        children: [
          for (var index = 0; index < perks.length; index++) ...[
            Expanded(
              child: Container(
                height: 112,
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: AppColors.borderStrong),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: AppColors.circleSurface,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          perks[index].$1,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      perks[index].$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const AppTextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (index < perks.length - 1) const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}
