import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class NearbyHostsSection extends StatelessWidget {
  const NearbyHostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const hosts = [
      ('Julian', 'ETA 2m'),
      ('Marcus', 'ETA 5m'),
      ('Elena', 'ETA 8m'),
    ];
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Live Nearby Hosts',
                  style: AppTextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CircleAvatar(radius: 4, backgroundColor: AppColors.loginGreen),
              SizedBox(width: 7),
              Text(
                'Live',
                style: AppTextStyle(
                  color: AppColors.loginGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (var index = 0; index < hosts.length; index++) ...[
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 124),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.borderStrong),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(AppImages.profile),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          hosts[index].$1,
                          style: const AppTextStyle(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          hosts[index].$2,
                          style: const AppTextStyle(
                            color: AppColors.textSoft,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (index < hosts.length - 1) const SizedBox(width: 10),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
