import 'package:flutter/material.dart';
import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/providers/user_mode_provider.dart';
import 'package:sharespot/features/common/auth/providers/onboarding_provider.dart';
import 'package:sharespot/features/common/auth/widgets/auth_flexible_gap.dart';
import 'package:sharespot/features/common/auth/widgets/auth_sheet_heading.dart';
import 'package:sharespot/features/common/auth/widgets/gradient_auth_scaffold.dart';
import 'package:sharespot/features/common/auth/widgets/onboarding_primary_button.dart';
import 'package:sharespot/features/common/auth/widgets/permission_access_tile.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  Future<void> _continue(BuildContext context) async {
    final success = await context
        .read<OnboardingProvider>()
        .finishPermissions();
    if (!context.mounted || !success) return;
    context.read<UserModeProvider>().reset();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.home,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();

    return GradientAuthScaffold(
      headerFraction: context.isCompactHeight ? 0.3 : 0.58,
      logoAlignment: const Alignment(0, 0.25),
      topPadding: context.isCompactHeight ? 18 : 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthSheetHeading(
            title: 'Allow Permissions',
            subtitle:
                '${AppConstants.appName} needs your location and notifications\nto find nearby parking.',
            subtitleFontSize: 14,
          ),
          const AuthFlexibleGap(height: 28),
          PermissionAccessTile(
            label: 'Location',
            isAllowed: provider.locationAllowed,
            onPressed: provider.allowLocation,
          ),
          const AuthFlexibleGap(height: 14),
          PermissionAccessTile(
            label: 'Notifications',
            isAllowed: provider.notificationsAllowed,
            onPressed: provider.allowNotifications,
          ),
          const AuthFlexibleGap(height: 24),
          const Center(
            child: Text(
              'Need Permissions for better matchmaking',
              textAlign: TextAlign.center,
              style: AppTextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const AuthFlexibleGap(height: 28),
          OnboardingPrimaryButton(
            label: 'Continue',
            isLoading: provider.isLoading,
            onPressed: () => _continue(context),
          ),
        ],
      ),
    );
  }
}
