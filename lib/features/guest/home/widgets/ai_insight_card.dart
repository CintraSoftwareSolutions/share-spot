import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class AiInsightCard extends StatelessWidget {
  const AiInsightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.fromLTRB(15, 14, 70, 15),
      decoration: BoxDecoration(
        color: AppColors.hexFF20263E,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppColors.hexFF41496A),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.authLink,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'AI Insight',
                    style: AppTextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11),
              Text.rich(
                TextSpan(
                  style: AppTextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    height: 1.35,
                  ),
                  children: [
                    TextSpan(text: 'Best time to arrive is between '),
                    TextSpan(
                      text: '8:30 AM and 9:15 AM',
                      style: AppTextStyle(color: AppColors.loginGreen),
                    ),
                    TextSpan(text: ' for a '),
                    TextSpan(
                      text: '98% success rate.',
                      style: AppTextStyle(color: AppColors.loginGreen),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: -70,
            bottom: -15,
            child: SvgPicture.asset(AppImages.aiInsight, width: 60, height: 39),
          ),
        ],
      ),
    );
  }
}
