import 'package:flutter/material.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/activity/models/parking_activity.dart';
import 'package:sharespot/features/shared/activity/models/activity_filter.dart';

class ActivityTimeline extends StatelessWidget {
  const ActivityTimeline({
    required this.activities,
    required this.filter,
    super.key,
  });

  final List<ParkingActivity> activities;
  final ActivityFilter filter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        children: [
          for (var index = 0; index < activities.length; index++)
            _TimelineEntry(
              activity: activities[index],
              filter: filter,
              isLast: index == activities.length - 1,
            ),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.activity,
    required this.filter,
    required this.isLast,
  });

  final ParkingActivity activity;
  final ActivityFilter filter;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final accent = switch (filter) {
      ActivityFilter.cancelled => AppColors.hexFFFF7A7A,
      _ => AppColors.loginGreen,
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned(
                    top: 18,
                    bottom: 0,
                    child: Container(width: 1, color: AppColors.authBorder),
                  ),
                Positioned(
                  top: 10,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.hexFF24402B,
                        width: 5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.28),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.authField,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.borderStrong),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          activity.place,
                          style: const AppTextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.hexFF10251A,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          activity.status,
                          style: AppTextStyle(
                            color: accent,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(activity.date, style: AppTextStyles.activityMeta),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 21,
                        backgroundImage: AssetImage(AppImages.profile),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity.address,
                              style: const AppTextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              activity.host,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.activityMeta,
                            ),
                          ],
                        ),
                      ),
                      if (activity.points > 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '+${activity.points}',
                              style: AppTextStyle(
                                color: accent,
                                fontSize: 18,
                                height: 1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'POINTS',
                              style: AppTextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                                height: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
