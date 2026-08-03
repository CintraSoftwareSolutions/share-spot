import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:sharespot/features/guest/activity/providers/activity_provider.dart';
import 'package:sharespot/features/common/auth/providers/auth_provider.dart';
import 'package:sharespot/features/common/auth/providers/onboarding_provider.dart';
import 'package:sharespot/features/common/auth/services/auth_service.dart';
import 'package:sharespot/features/common/auth/services/onboarding_service.dart';
import 'package:sharespot/features/guest/home/providers/home_provider.dart';
import 'package:sharespot/features/guest/home/providers/parking_insights_provider.dart';
import 'package:sharespot/features/guest/home/services/home_service.dart';
import 'package:sharespot/features/host/activity/providers/host_activity_provider.dart';
import 'package:sharespot/features/host/messages/providers/host_messages_provider.dart';
import 'package:sharespot/features/guest/messages/providers/messages_provider.dart';
import 'package:sharespot/features/guest/navigation/providers/navigation_provider.dart'
    as guest_navigation;
import 'package:sharespot/features/host/navigation/providers/navigation_provider.dart'
    as host_navigation;
import 'package:sharespot/features/guest/notifications/providers/notification_settings_provider.dart'
    as guest_notifications;
import 'package:sharespot/features/host/notifications/providers/notification_settings_provider.dart'
    as host_notifications;
import 'package:sharespot/features/guest/profile/providers/profile_provider.dart'
    as guest_profile;
import 'package:sharespot/features/host/profile/providers/profile_provider.dart'
    as host_profile;
import 'package:sharespot/features/common/settings/providers/app_settings_provider.dart';
import 'package:sharespot/core/providers/user_mode_provider.dart';

abstract final class AppProviders {
  static List<SingleChildWidget> create() {
    return [
      ChangeNotifierProvider(create: (_) => AppSettingsProvider()),
      ChangeNotifierProvider(create: (_) => UserModeProvider()),
      ChangeNotifierProvider(
        create: (_) => guest_navigation.NavigationProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => host_navigation.NavigationProvider(),
      ),
      ChangeNotifierProvider(create: (_) => ActivityProvider()),
      ChangeNotifierProvider(create: (_) => HostActivityProvider()),
      ChangeNotifierProvider(create: (_) => HostMessagesProvider()),
      ChangeNotifierProvider(create: (_) => MessagesProvider()),
      ChangeNotifierProvider(create: (_) => ParkingInsightsProvider()),
      ChangeNotifierProvider(create: (_) => guest_profile.ProfileProvider()),
      ChangeNotifierProvider(create: (_) => host_profile.ProfileProvider()),
      ChangeNotifierProvider(
        create: (_) => guest_notifications.NotificationSettingsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => host_notifications.NotificationSettingsProvider(),
      ),
      Provider<AuthService>(create: (_) => const AuthService()),
      Provider<OnboardingService>(create: (_) => const OnboardingService()),
      Provider<HomeService>(create: (_) => const HomeService()),
      ChangeNotifierProvider(
        create: (context) =>
            AuthProvider(authService: context.read<AuthService>()),
      ),
      ChangeNotifierProvider(
        create: (context) => OnboardingProvider(
          onboardingService: context.read<OnboardingService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            HomeProvider(homeService: context.read<HomeService>())..loadItems(),
      ),
    ];
  }
}
