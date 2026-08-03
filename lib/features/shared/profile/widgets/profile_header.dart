import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.name,
    required this.role,
    required this.onEdit,
    super.key,
  });

  final String name;
  final String role;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 94,
                height: 94,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textSecondary,
                  image: DecorationImage(
                    image: AssetImage(AppImages.profile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 3,
                bottom: 5,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.loginGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2.5),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.greenInk,
                    size: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: const AppTextStyle(
              color: AppColors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$role • San Francisco, CA',
            style: const AppTextStyle(
              color: AppColors.hexFFD1D2D6,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 42,
            child: OutlinedButton(
              onPressed: onEdit,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.loginGreen,
                backgroundColor: AppColors.hexFF090B0E,
                side: const BorderSide(color: AppColors.hexFF243126),
                padding: const EdgeInsets.symmetric(horizontal: 19),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Edit Profile',
                style: AppTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
