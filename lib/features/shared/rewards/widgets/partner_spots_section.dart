import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class PartnerSpotsSection extends StatelessWidget {
  const PartnerSpotsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const spots = [
      (AppImages.cutlery, 'Verona Italian', '0.4 miles'),
      (AppImages.steamAndBean, 'Steam & Bean', '1.2 miles'),
      (AppImages.fireAndSlice, 'Fire & Slice', '2.1 miles'),
    ];

    return Row(
      children: [
        for (var index = 0; index < spots.length; index++) ...[
          Expanded(
            child: Container(
              height: context.isMobile ? 124 : 140,
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.authField,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: AppColors.borderStrong),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.circleSurface,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        spots[index].$1,
                        width: index == 0 ? 12 : 17,
                        height: 16,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    spots[index].$2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const AppTextStyle(
                      color: AppColors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    spots[index].$3,
                    style: const AppTextStyle(
                      color: AppColors.hexFFB5B7BD,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (index < spots.length - 1) const SizedBox(width: 12),
        ],
      ],
    );
  }
}
