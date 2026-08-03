import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/features/common/auth/providers/onboarding_provider.dart';
import 'package:sharespot/features/common/auth/widgets/auth_flexible_gap.dart';
import 'package:sharespot/features/common/auth/widgets/auth_sheet_heading.dart';
import 'package:sharespot/features/common/auth/widgets/gradient_auth_scaffold.dart';
import 'package:sharespot/features/common/auth/widgets/onboarding_primary_button.dart';
import 'package:sharespot/features/common/auth/widgets/profile_photo_picker.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  Future<void> _continue(BuildContext context) async {
    final success = await context.read<OnboardingProvider>().saveProfile();
    if (!context.mounted || !success) return;
    Navigator.pushNamed(context, AppRouteNames.vehicleDetails);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<OnboardingProvider, bool>(
      (provider) => provider.isLoading,
    );

    return GradientAuthScaffold(
      headerFraction: context.isCompactHeight ? 0.3 : 0.635,
      logoAlignment: const Alignment(0, 0.2),
      topPadding: context.isCompactHeight ? 18 : 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AuthSheetHeading(
            title: 'Set Up Your Profile',
            subtitle: 'Tell us a little about you.',
          ),
          AuthFlexibleGap(height: context.isCompactHeight ? 12 : 28),
          const Text(
            'Profile Photo (optional)',
            style: AppTextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          AuthFlexibleGap(height: context.isCompactHeight ? 8 : 10),
          ProfilePhotoPicker(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Photo picker will be connected here.'),
              ),
            ),
          ),
          AuthFlexibleGap(height: context.isCompactHeight ? 12 : 30),
          OnboardingPrimaryButton(
            label: 'Skip For Now',
            outlined: true,
            isLoading: isLoading,
            onPressed: () => _continue(context),
          ),
        ],
      ),
    );
  }
}
