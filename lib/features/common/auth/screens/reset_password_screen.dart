import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/features/common/auth/providers/onboarding_provider.dart';
import 'package:sharespot/features/common/auth/widgets/auth_flexible_gap.dart';
import 'package:sharespot/features/common/auth/widgets/auth_sheet_heading.dart';
import 'package:sharespot/features/common/auth/widgets/auth_text_field.dart';
import 'package:sharespot/features/common/auth/widgets/gradient_auth_scaffold.dart';
import 'package:sharespot/features/common/auth/widgets/onboarding_primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    final success = await context.read<OnboardingProvider>().resetPassword(
      _passwordController.text,
    );
    if (!mounted || !success) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.login,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<OnboardingProvider, bool>(
      (provider) => provider.isLoading,
    );

    return GradientAuthScaffold(
      showBack: true,
      headerFraction: context.isCompactHeight ? 0.2 : 0.58,
      logoAlignment: const Alignment(0, 0.08),
      topPadding: context.isCompactHeight ? 18 : 24,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthSheetHeading(
              title: 'Set a New Key',
              subtitle: 'Choose a strong new password to secure your account.',
            ),
            const AuthFlexibleGap(height: 24),
            AuthTextField(
              controller: _passwordController,
              label: 'New Password',
              hintText: 'Enter your new password',
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.iconSubtle,
                  size: 20,
                ),
              ),
              validator: (value) {
                if ((value ?? '').length < 6) {
                  return 'Password must contain at least 6 characters';
                }
                return null;
              },
            ),
            const AuthFlexibleGap(height: 18),
            AuthTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hintText: 'Enter your password again',
              obscureText: _obscureConfirmation,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _resetPassword(),
              suffixIcon: IconButton(
                onPressed: () => setState(
                  () => _obscureConfirmation = !_obscureConfirmation,
                ),
                tooltip: _obscureConfirmation
                    ? 'Show password'
                    : 'Hide password',
                icon: Icon(
                  _obscureConfirmation
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.iconSubtle,
                  size: 20,
                ),
              ),
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const AuthFlexibleGap(height: 28),
            OnboardingPrimaryButton(
              label: 'Reset',
              isLoading: isLoading,
              onPressed: _resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
