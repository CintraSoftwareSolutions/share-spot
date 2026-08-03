import 'package:flutter/material.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/notifications/models/app_notification.dart';
import 'package:sharespot/features/shared/notifications/widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const _notifications = [
    AppNotification(
      title: 'Parking Spot Found',
      message: 'Sarah Wilson is leaving a parking spot 300m away.',
      isUnread: true,
    ),
    AppNotification(
      title: 'Request Accepted',
      message: 'Navigate to Central Mall Parking and meet your host.',
      isUnread: true,
    ),
    AppNotification(
      title: 'Guest Arriving Soon',
      message: 'Sarah Wilson is arriving at the handover point.',
    ),
    AppNotification(
      title: 'Marcus Lee sent you a message',
      message: 'I am parked beside Entrance B.',
      isUnread: true,
    ),
    AppNotification(
      title: 'Parking Exchange Completed',
      message: 'You earned +50 Reward Points.',
    ),
    AppNotification(
      title: 'Rate Your Experience',
      message: 'Rate your parking exchange with Marcus Lee.',
    ),
    AppNotification(
      title: 'Reward Unlocked',
      message: 'Redeem 20% Off at Bella Italia.',
    ),
    AppNotification(
      title: 'New Parking Spot Available',
      message: 'A parking spot is available near Office Central.',
      isUnread: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.isMobile ? 20.0 : 32.0;
    final headerLeftPadding = context.isMobile ? 8.0 : 20.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 8),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    headerLeftPadding,
                    10,
                    horizontalPadding,
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
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          'Notifications',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.subheading.copyWith(
                            color: AppColors.white,
                            fontSize: 16,
                            height: 1.2,
                            decoration: TextDecoration.none,
                            decorationColor: AppColors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    key: const PageStorageKey<String>(
                      'guest-notifications-list',
                    ),
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      4,
                      horizontalPadding,
                      context.isMobile ? 16 : 24,
                    ),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: _notifications.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) => NotificationCard(
                      key: ValueKey<String>(
                        'guest-notification-${_notifications[index].title}',
                      ),
                      notification: _notifications[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
