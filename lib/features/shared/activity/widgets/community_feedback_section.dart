import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class CommunityFeedbackSection extends StatelessWidget {
  const CommunityFeedbackSection({this.reviews = defaultReviews, super.key});

  final List<(String, String, String)> reviews;

  static const defaultReviews = <(String, String, String)>[
    (
      'Sarah Miller',
      '2 days ago',
      '“Incredibly smooth swap. The item was exactly as described and communication was lightning fast. Highly recommend for any tech swaps!”',
    ),
    (
      'David Kenji',
      'Last week',
      '“Great host! Punctual and very professional. The location was easy to find and the process took less than 5 minutes.”',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Community Feedback',
            style: AppTextStyles.subheading.copyWith(
              color: AppColors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 14),
          for (var index = 0; index < reviews.length; index++) ...[
            _FeedbackCard(review: reviews[index]),
            if (index < reviews.length - 1) const SizedBox(height: 18),
          ],
        ],
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({required this.review});

  final (String, String, String) review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 19),
      decoration: const BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(18)),
        border: Border(left: BorderSide(color: AppColors.loginGreen, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppImages.profile),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.$1,
                      style: const AppTextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.$2,
                      style: const AppTextStyle(
                        color: AppColors.hexFFB1B3B9,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.loginGreen,
                    size: 18,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.loginGreen,
                    size: 18,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.loginGreen,
                    size: 18,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.loginGreen,
                    size: 18,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: AppColors.loginGreen,
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(review.$3, style: AppTextStyles.communityReview),
        ],
      ),
    );
  }
}
