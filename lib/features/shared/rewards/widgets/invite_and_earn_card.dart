import 'package:flutter/material.dart';
import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class InviteAndEarnCard extends StatelessWidget {
  const InviteAndEarnCard({required this.onRefer, super.key});

  final VoidCallback onRefer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.hexFF3E356D),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.hexFF2B2059, AppColors.hexFF1B1926],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(
                AppImages.inviteAndEarn,
                width: 78,
                height: 55,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 62),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Invite & Earn',
                  style: AppTextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Earn 500 bonus points for every friend who joins ${AppConstants.appName} and makes their first swap.',
                  style: AppTextStyle(
                    color: AppColors.hexFFD0CEDC,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 46,
                  child: FilledButton(
                    onPressed: onRefer,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.authLink,
                      foregroundColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Refer Now',
                      style: AppTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
