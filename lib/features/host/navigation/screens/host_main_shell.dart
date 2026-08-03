import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/features/host/navigation/providers/navigation_provider.dart';
import 'package:sharespot/features/shared/navigation/widgets/app_bottom_navigation.dart';
import 'package:sharespot/features/host/home/screens/host_home_screen.dart';
import 'package:sharespot/features/host/activity/screens/host_activity_screen.dart';
import 'package:sharespot/features/host/messages/screens/host_messages_screen.dart';
import 'package:sharespot/features/host/rewards/screens/host_rewards_screen.dart';
import 'package:sharespot/features/host/profile/screens/host_profile_screen.dart';

class HostMainShell extends StatelessWidget {
  const HostMainShell({super.key});

  static const _pages = [
    HostHomeScreen(),
    HostActivityScreen(),
    HostRewardsScreen(),
    HostMessagesScreen(),
    HostProfileScreen(),
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
