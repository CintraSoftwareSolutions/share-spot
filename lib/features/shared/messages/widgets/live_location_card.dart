import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class LiveLocationCard extends StatelessWidget {
  const LiveLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.isMobile ? 150 : 178,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppImages.map,
                  fit: BoxFit.cover,
                  color: AppColors.hexB0101114,
                  colorBlendMode: BlendMode.darken,
                ),
                const Center(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.loginGreen,
                    child: Icon(
                      Icons.directions_car_filled_rounded,
                      color: AppColors.authSurface,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Live Location Sharing',
                    style: AppTextStyle(
                      color: AppColors.hexFFC4C6CB,
                      fontSize: 12,
                    ),
                  ),
                ),
                CircleAvatar(radius: 4, backgroundColor: AppColors.loginGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
