import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/notifications/models/app_notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({required this.notification, super.key});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final isCompact = context.screenWidth < 360;

    return Container(
      constraints: BoxConstraints(minHeight: context.isMobile ? 64 : 72),
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 12 : 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Row(
        children: [
          Container(
            width: isCompact ? 34 : 36,
            height: isCompact ? 34 : 36,
            decoration: const BoxDecoration(
              color: AppColors.hexFF173621,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.greenBell,
                width: isCompact ? 18 : 20,
                height: isCompact ? 18 : 20,
              ),
            ),
          ),
          SizedBox(width: isCompact ? 10 : 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.notificationTitle,
                      ),
                    ),
                    if (notification.isUnread)
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor: AppColors.loginGreen,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.notificationBody,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
