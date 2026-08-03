import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_page_scaffold.dart';
import 'package:sharespot/features/guest/notifications/providers/notification_settings_provider.dart';
import 'package:sharespot/features/shared/notifications/widgets/notification_preference_tile.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  Future<void> _save(BuildContext context) async {
    final success = await context.read<NotificationSettingsProvider>().save();
    if (!context.mounted || !success) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification preferences saved.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<NotificationSettingsProvider>();
    final padding = context.isMobile ? 20.0 : 32.0;
    return ProfilePageScaffold(
      title: 'Notifications',
      actionLabel: 'Save Details',
      onAction: () => _save(context),
      isLoading: settings.isLoading,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: context.screenWidth,
          margin: EdgeInsets.fromLTRB(padding, 18, padding, 0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderStrong),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NotificationPreferenceTile(
                label: 'Parking Alerts',
                value: settings.parkingAlerts,
                onChanged: settings.setParkingAlerts,
              ),
              NotificationPreferenceTile(
                label: 'Match Requests',
                value: settings.matchRequests,
                onChanged: settings.setMatchRequests,
              ),
              NotificationPreferenceTile(
                label: 'Messages',
                value: settings.messages,
                onChanged: settings.setMessages,
              ),
              NotificationPreferenceTile(
                label: 'Arrival Alerts',
                value: settings.arrivalAlerts,
                onChanged: settings.setArrivalAlerts,
              ),
              NotificationPreferenceTile(
                label: 'Promotions',
                value: settings.promotions,
                onChanged: settings.setPromotions,
              ),
              NotificationPreferenceTile(
                label: 'Push Notifications',
                value: settings.pushNotifications,
                onChanged: settings.setPushNotifications,
                showDivider: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
