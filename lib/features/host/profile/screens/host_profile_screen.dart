import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/providers/user_mode_provider.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/widgets/switch_mode_dialog.dart';
import 'package:sharespot/features/host/navigation/providers/navigation_provider.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_header.dart';
import 'package:sharespot/features/shared/profile/widgets/logout_confirmation_dialog.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_menu_group.dart';
import 'package:sharespot/features/shared/profile/widgets/profile_stats_card.dart';
import 'package:sharespot/features/host/profile/providers/profile_provider.dart';

class HostProfileScreen extends StatelessWidget {
  const HostProfileScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.72),
      builder: (_) => const LogoutConfirmationDialog(),
    );
    if (!context.mounted || confirmed != true) return;
    context.read<UserModeProvider>().reset();
    context.read<NavigationProvider>().reset();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.login,
      (_) => false,
    );
  }

  Future<void> _switchMode(BuildContext context, AppUserMode targetMode) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.74),
      builder: (_) => SwitchModeDialog(targetMode: targetMode),
    );
    if (!context.mounted || confirmed != true) return;
    final modeProvider = context.read<UserModeProvider>();
    final navigationProvider = context.read<NavigationProvider>();
    modeProvider.switchTo(targetMode);
    navigationProvider.reset();
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    final profileName = context.select<ProfileProvider, String>(
      (provider) => provider.name,
    );
    final isHost = context.select<UserModeProvider, bool>(
      (provider) => provider.isHost,
    );
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.fromLTRB(padding, 26, padding, 28),
          children: [
            ProfileHeader(
              name: profileName,
              role: isHost ? 'Host' : 'Guest',
              onEdit: () => Navigator.pushNamed(
                context,
                AppRouteNames.hostProfileSettings,
              ),
            ),
            const SizedBox(height: 24),
            const ProfileStatsCard(),
            const SizedBox(height: 25),
            ProfileMenuGroup(
              heading: 'Account',
              items: [
                ProfileMenuItem(
                  label: 'Profile Settings',
                  icon: Icons.person_outline_rounded,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouteNames.hostProfileSettings,
                  ),
                ),
                ProfileMenuItem(
                  label: 'Vehicle Management',
                  subtitle: 'Manage handovers',
                  icon: Icons.directions_car_outlined,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouteNames.hostVehicleManagement,
                  ),
                ),
                ProfileMenuItem(
                  label: 'Favorite Locations',
                  icon: Icons.favorite_border_rounded,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRouteNames.hostFavorites),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ProfileMenuGroup(
              heading: 'Preferences',
              items: [
                ProfileMenuItem(
                  label: 'Notifications',
                  icon: Icons.notifications_none_rounded,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouteNames.hostNotificationSettings,
                  ),
                ),
                ProfileMenuItem(
                  label: 'Privacy & Safety',
                  svgAsset: AppImages.privacyAndSafety,
                  onTap: () => _showMessage(
                    context,
                    'Privacy and safety settings will open here.',
                  ),
                ),
                ProfileMenuItem(
                  label: 'Help & Support',
                  svgAsset: AppImages.helpAndSupport,
                  onTap: () =>
                      _showMessage(context, 'Help and support will open here.'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _ProfileButton(
              label: isHost ? 'Switch To Guest' : 'Switch To Host',
              icon: Icons.swap_horiz_rounded,
              color: AppColors.loginGreen,
              onTap: () => _switchMode(
                context,
                isHost ? AppUserMode.guest : AppUserMode.host,
              ),
            ),
            const SizedBox(height: 11),
            _ProfileButton(
              label: 'Logout',
              icon: Icons.logout_rounded,
              color: AppColors.error,
              onTap: () => _confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: 54,
      child: OutlinedButton.icon(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: AppColors.authField,
          side: const BorderSide(color: AppColors.borderStrong),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        icon: Icon(icon, size: 17),
        label: Text(
          label,
          style: const AppTextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
