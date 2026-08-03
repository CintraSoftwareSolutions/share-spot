import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/activity/models/activity_filter.dart';

class ActivityFilterTabs extends StatelessWidget {
  const ActivityFilterTabs({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final ActivityFilter selected;
  final ValueChanged<ActivityFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Row(
        children: ActivityFilter.values
            .map((filter) {
              final isSelected = filter == selected;
              final label = switch (filter) {
                ActivityFilter.upcoming => 'Upcoming',
                ActivityFilter.completed => 'Completed',
                ActivityFilter.cancelled => 'Cancelled',
              };
              return Expanded(
                child: InkWell(
                  onTap: () => onSelected(filter),
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.hexFF223329
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: AppTextStyle(
                        color: isSelected
                            ? AppColors.loginGreen
                            : AppColors.hexFFC4C6CB,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}
