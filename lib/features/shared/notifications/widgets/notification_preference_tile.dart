import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/theme/app_colors.dart';

class NotificationPreferenceTile extends StatelessWidget {
  const NotificationPreferenceTile({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
    this.showDivider = true,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 14, right: 7),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.hexFF2B2D32))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const AppTextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.72,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppColors.authLink,
              activeThumbColor: AppColors.white,
              inactiveTrackColor: AppColors.hexFF303238,
              inactiveThumbColor: AppColors.hexFF95979D,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
