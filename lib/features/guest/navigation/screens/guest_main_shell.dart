import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/features/guest/activity/screens/activity_screen.dart';
import 'package:sharespot/features/guest/home/screens/parking_home_screen.dart';
import 'package:sharespot/features/guest/messages/screens/guest_messages_screen.dart';
import 'package:sharespot/features/guest/navigation/providers/navigation_provider.dart';
import 'package:sharespot/features/shared/navigation/widgets/app_bottom_navigation.dart';
import 'package:sharespot/features/guest/profile/screens/guest_profile_screen.dart';
import 'package:sharespot/features/guest/rewards/screens/rewards_screen.dart';

class GuestMainShell extends StatelessWidget {
  const GuestMainShell({super.key});

  static const _pages = [
    ParkingHomeScreen(),
    ActivityScreen(),
    RewardsScreen(),
    GuestMessagesScreen(),
    GuestProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.select<NavigationProvider, int>(
      (provider) => provider.selectedIndex,
    );
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: context.screenWidth,
        height: context.screenHeight,
        child: IndexedStack(index: selectedIndex, children: _pages),
      ),
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: selectedIndex,
        onSelected: context.read<NavigationProvider>().select,
      ),
    );
  }
}
