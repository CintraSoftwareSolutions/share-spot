import 'package:flutter/material.dart';

import 'package:sharespot/features/guest/activity/screens/wait_and_dine_screen.dart';
import 'package:sharespot/features/host/activity/screens/wait_and_dine_screen.dart';
import 'package:sharespot/features/common/auth/screens/create_account_screen.dart';
import 'package:sharespot/features/common/auth/screens/forgot_password_screen.dart';
import 'package:sharespot/features/common/auth/screens/login_screen.dart';
import 'package:sharespot/features/common/auth/screens/permissions_screen.dart';
import 'package:sharespot/features/common/auth/screens/profile_setup_screen.dart';
import 'package:sharespot/features/common/auth/screens/reset_password_screen.dart';
import 'package:sharespot/features/common/auth/screens/vehicle_details_screen.dart';
import 'package:sharespot/features/common/auth/screens/verify_email_screen.dart';
import 'package:sharespot/features/common/navigation/screens/main_shell.dart';
import 'package:sharespot/features/guest/messages/screens/chat_detail_screen.dart';
import 'package:sharespot/features/host/messages/screens/host_chat_detail_screen.dart';
import 'package:sharespot/features/shared/messages/models/chat_conversation.dart';
import 'package:sharespot/features/guest/home/screens/parking_insights_screen.dart';
import 'package:sharespot/features/host/notifications/screens/host_notifications_screen.dart';
import 'package:sharespot/features/host/rewards/screens/host_available_rewards_screen.dart';
import 'package:sharespot/features/host/rewards/screens/host_recent_rewards_activity_screen.dart';
import 'package:sharespot/features/shared/home/models/parking_detail_arguments.dart';
import 'package:sharespot/features/guest/notifications/screens/notifications_screen.dart';
import 'package:sharespot/features/guest/notifications/screens/notification_settings_screen.dart';
import 'package:sharespot/features/host/notifications/screens/host_notification_settings_screen.dart';
import 'package:sharespot/features/guest/profile/screens/favorites_screen.dart';
import 'package:sharespot/features/guest/profile/screens/profile_settings_screen.dart';
import 'package:sharespot/features/guest/profile/screens/vehicle_management_screen.dart';
import 'package:sharespot/features/host/profile/screens/favorites_screen.dart'
    as host_profile;
import 'package:sharespot/features/host/profile/screens/profile_settings_screen.dart'
    as host_profile;
import 'package:sharespot/features/host/profile/screens/vehicle_management_screen.dart'
    as host_profile;
import 'package:sharespot/features/guest/rewards/screens/available_rewards_screen.dart';
import 'package:sharespot/features/guest/rewards/screens/recent_rewards_activity_screen.dart';
import 'package:sharespot/features/common/settings/screens/settings_screen.dart';
import 'package:sharespot/features/common/splash/screens/splash_screen.dart';
import 'package:sharespot/core/screens/not_found_screen.dart';
import 'app_route_names.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final page = switch (settings.name) {
      AppRouteNames.splash => const SplashScreen(),
      AppRouteNames.login => const LoginScreen(),
      AppRouteNames.forgotPassword => const ForgotPasswordScreen(),
      AppRouteNames.resetPassword => const ResetPasswordScreen(),
      AppRouteNames.createAccount => const CreateAccountScreen(),
      AppRouteNames.verifyEmail => const VerifyEmailScreen(),
      AppRouteNames.profileSetup => const ProfileSetupScreen(),
      AppRouteNames.vehicleDetails => const VehicleDetailsScreen(),
      AppRouteNames.permissions => const PermissionsScreen(),
      AppRouteNames.notifications => const NotificationsScreen(),
      AppRouteNames.notificationSettings => const NotificationSettingsScreen(),
      AppRouteNames.hostNotificationSettings =>
        const HostNotificationSettingsScreen(),
      AppRouteNames.hostNotifications => const HostNotificationsScreen(),
      AppRouteNames.hostAvailableRewards => const HostAvailableRewardsScreen(),
      AppRouteNames.hostRecentRewardsActivity =>
        const HostRecentRewardsActivityScreen(),
      AppRouteNames.waitAndDine => const GuestWaitAndDineScreen(),
      AppRouteNames.hostWaitAndDine => const HostWaitAndDineScreen(),
      AppRouteNames.availableRewards => const AvailableRewardsScreen(),
      AppRouteNames.recentRewardsActivity =>
        const RecentRewardsActivityScreen(),
      AppRouteNames.parkingInsights => ParkingInsightsScreen(
        details: settings.arguments is ParkingDetailArguments
            ? settings.arguments! as ParkingDetailArguments
            : ParkingInsightsScreen.defaultDetails,
      ),
      AppRouteNames.profileSettings => const ProfileSettingsScreen(),
      AppRouteNames.hostProfileSettings =>
        const host_profile.ProfileSettingsScreen(),
      AppRouteNames.vehicleManagement => const VehicleManagementScreen(),
      AppRouteNames.hostVehicleManagement =>
        const host_profile.VehicleManagementScreen(),
      AppRouteNames.favorites => const FavoritesScreen(),
      AppRouteNames.hostFavorites => const host_profile.FavoritesScreen(),
      AppRouteNames.chatDetail => ChatDetailScreen(
        conversation: settings.arguments is ChatConversation
            ? settings.arguments! as ChatConversation
            : null,
      ),
      AppRouteNames.hostChatDetail => HostChatDetailScreen(
        conversation: settings.arguments is ChatConversation
            ? settings.arguments! as ChatConversation
            : null,
      ),
      AppRouteNames.home => const MainShell(),
      AppRouteNames.settings => const SettingsScreen(),
      _ => NotFoundScreen(routeName: settings.name),
    };

    return MaterialPageRoute<void>(builder: (_) => page, settings: settings);
  }
}
