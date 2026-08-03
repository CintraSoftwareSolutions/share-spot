import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/guest/activity/providers/activity_provider.dart';
import 'package:sharespot/features/shared/activity/models/activity_filter.dart';
import 'package:sharespot/features/shared/activity/widgets/activity_filter_tabs.dart';
import 'package:sharespot/features/shared/activity/widgets/activity_summary_card.dart';
import 'package:sharespot/features/shared/activity/widgets/activity_timeline.dart';
import 'package:sharespot/features/shared/activity/widgets/community_feedback_section.dart';
import 'package:sharespot/features/shared/activity/widgets/earned_badges_section.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    final filter = context.select<ActivityProvider, ActivityFilter>(
      (provider) => provider.filter,
    );
    final activities = context.watch<ActivityProvider>().activities;

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
            const ActivitySummaryCard(),
            const SizedBox(height: 16),
            ActivityFilterTabs(
              selected: filter,
              onSelected: context.read<ActivityProvider>().selectFilter,
            ),
            const SizedBox(height: 16),
            ActivityTimeline(activities: activities, filter: filter),
            const SizedBox(height: 26),
            const EarnedBadgesSection(),
            const SizedBox(height: 30),
            const CommunityFeedbackSection(),
          ],
        ),
      ),
    );
  }
}
