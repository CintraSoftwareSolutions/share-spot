import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/activity/models/activity_filter.dart';
import 'package:sharespot/features/shared/activity/widgets/activity_filter_tabs.dart';
import 'package:sharespot/features/shared/activity/widgets/activity_summary_card.dart';
import 'package:sharespot/features/shared/activity/widgets/activity_timeline.dart';
import 'package:sharespot/features/shared/activity/widgets/community_feedback_section.dart';
import 'package:sharespot/features/shared/activity/widgets/earned_badges_section.dart';
import 'package:sharespot/features/host/activity/providers/host_activity_provider.dart';

class HostActivityScreen extends StatelessWidget {
  const HostActivityScreen({super.key});

  static const _summaryStats = <(String, String)>[
    ('Parking\nExchanges', '124'),
    ('Active\nListings', '12'),
    ('Response\nTime', '2 Mins'),
    ('Rating', '4.8'),
    ('Success', '98%'),
    ('Level', 'Elite Tier'),
  ];

  static const _badges = <(String, String)>[
    (AppImages.trustedDriver, 'Trusted Host'),
    (AppImages.fastResponder, 'Fast Responder'),
    (AppImages.profileReward, 'Community Favorite'),
  ];

  static const _feedback = <(String, String, String)>[
    (
      'Sarah Miller',
      '2 days ago',
      '“Excellent host. Shared exact location and timing. The handover was smooth and fast.”',
    ),
    (
      'David Kenji',
      'Last week',
      '“Very reliable and easy to coordinate with. The parking spot was ready exactly when promised.”',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    final filter = context.select<HostActivityProvider, ActivityFilter>(
      (provider) => provider.filter,
    );
    final activities = context.watch<HostActivityProvider>().activities;

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(padding, 22, padding, 28),
          children: [
            Text(
              'Activity',
              style: AppTextStyles.subheading.copyWith(
                color: AppColors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 17),
            const ActivitySummaryCard(points: '3,250', stats: _summaryStats),
            const SizedBox(height: 16),
            ActivityFilterTabs(
              selected: filter,
              onSelected: context.read<HostActivityProvider>().selectFilter,
            ),
            const SizedBox(height: 16),
            ActivityTimeline(activities: activities, filter: filter),
            const SizedBox(height: 26),
            const EarnedBadgesSection(
              badges: _badges,
              firstProgressLabel: 'Acceptance Rate',
              firstProgressValue: '98%',
              secondProgressLabel: 'Request Success',
              secondProgressValue: '94%',
            ),
            const SizedBox(height: 30),
            const CommunityFeedbackSection(reviews: _feedback),
          ],
        ),
      ),
    );
  }
}
