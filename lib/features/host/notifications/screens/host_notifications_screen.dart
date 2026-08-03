import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/notifications/models/app_notification.dart';
import 'package:sharespot/features/shared/notifications/widgets/notification_card.dart';

class HostNotificationsScreen extends StatelessWidget {
  const HostNotificationsScreen({super.key});

  static const _notifications = [
    AppNotification(
      title: 'New Parking Request',
      message: 'Leaving in 12 mins • Downtown Plaza',
      isUnread: true,
    ),
    AppNotification(
      title: 'Request Accepted',
      message: 'Michael Carter is on the way to your location.',
      isUnread: true,
    ),
    AppNotification(
      title: 'Guest Arriving Soon',
      message: 'Prepare for handover at Central Mall Parking.',
    ),
    AppNotification(
      title: 'Marcus Lee sent you a message',
      message: 'I’m entering the parking lot now.',
      isUnread: true,
    ),
    AppNotification(
      title: 'Parking Exchange Completed',
      message: 'You earned +50 Reward Points.',
    ),
    AppNotification(
      title: 'Rate Your Experience',
      message: 'How did Carter rate your hosting experience?',
    ),
    AppNotification(
      title: 'Reward Unlocked',
      message: 'You’ve completed 50 successful parking exchanges.',
    ),
    AppNotification(
      title: 'Reward Earned',
      message: 'You earned +30 points for responding quickly.',
      isUnread: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.isMobile ? 8 : 20,
                10,
                padding,
                12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    tooltip: 'Back',
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    'Notifications',
                    style: AppTextStyles.subheading.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(padding, 6, padding, 24),
                itemCount: _notifications.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    NotificationCard(notification: _notifications[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
