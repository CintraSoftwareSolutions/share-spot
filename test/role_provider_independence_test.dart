import 'package:flutter_test/flutter_test.dart';
import 'package:sharespot/features/guest/messages/providers/messages_provider.dart'
    as guest_messages;
import 'package:sharespot/features/guest/navigation/providers/navigation_provider.dart'
    as guest_navigation;
import 'package:sharespot/features/guest/notifications/providers/notification_settings_provider.dart'
    as guest_notifications;
import 'package:sharespot/features/guest/profile/providers/profile_provider.dart'
    as guest_profile;
import 'package:sharespot/features/host/messages/providers/host_messages_provider.dart';
import 'package:sharespot/features/host/navigation/providers/navigation_provider.dart'
    as host_navigation;
import 'package:sharespot/features/host/notifications/providers/notification_settings_provider.dart'
    as host_notifications;
import 'package:sharespot/features/host/profile/providers/profile_provider.dart'
    as host_profile;

void main() {
  test('guest and host providers keep independent backend state', () async {
    final guestProfile = guest_profile.ProfileProvider();
    final hostProfile = host_profile.ProfileProvider();
    await guestProfile.saveProfile(
      name: 'Guest Alex',
      email: guestProfile.email,
      location: guestProfile.location,
    );
    expect(guestProfile.name, 'Guest Alex');
    expect(hostProfile.name, 'Alex Carter');

    final guestMessages = guest_messages.MessagesProvider();
    final hostMessages = HostMessagesProvider();
    final guestConversation = guestMessages.conversations.first;
    guestMessages.completeExchange(guestConversation.name);
    expect(guestMessages.isExchangeCompleted(guestConversation), isTrue);
    expect(hostMessages.isExchangeCompleted(guestConversation), isFalse);

    final guestNavigation = guest_navigation.NavigationProvider()..select(3);
    final hostNavigation = host_navigation.NavigationProvider();
    expect(guestNavigation.selectedIndex, 3);
    expect(hostNavigation.selectedIndex, 0);

    final guestNotifications =
        guest_notifications.NotificationSettingsProvider()
          ..setParkingAlerts(false);
    final hostNotifications = host_notifications.NotificationSettingsProvider();
    expect(guestNotifications.parkingAlerts, isFalse);
    expect(hostNotifications.parkingAlerts, isTrue);
  });
}
