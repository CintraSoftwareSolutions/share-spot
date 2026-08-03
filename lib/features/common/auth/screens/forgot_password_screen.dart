import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/common/auth/providers/onboarding_provider.dart';
import 'package:sharespot/features/common/auth/widgets/auth_flexible_gap.dart';
import 'package:sharespot/features/common/auth/widgets/auth_sheet_heading.dart';
import 'package:sharespot/features/common/auth/widgets/auth_text_field.dart';
import 'package:sharespot/features/common/auth/widgets/gradient_auth_scaffold.dart';
import 'package:sharespot/features/common/auth/widgets/onboarding_primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    final success = await context
        .read<OnboardingProvider>()
        .requestPasswordReset(_emailController.text.trim());
    if (!mounted || !success) return;
    Navigator.pushNamed(context, AppRouteNames.resetPassword);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<OnboardingProvider, bool>(
      (provider) => provider.isLoading,
    );

    return GradientAuthScaffold(
      showBack: true,
      headerFraction: context.isCompactHeight ? 0.2 : 0.67,
      logoAlignment: const Alignment(0, 0.2),
      topPadding: context.isCompactHeight
          ? 20
          : context.textScale > 1
          ? 24
          : 26,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthSheetHeading(
              title: "Let's Get You Back",
              subtitle: 'Enter your email to reset your password.',
            ),
            const AuthFlexibleGap(height: 24),
            AuthTextField(
              controller: _emailController,
              label: 'Email Address',
              hintText: 'alex66@gmail.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _sendResetLink(),
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
                color: AppColors.iconMuted,
                size: 20,
              ),
              validator: (value) {
                final email = value?.trim() ?? '';
                if (!email.contains('@') || !email.contains('.')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const AuthFlexibleGap(height: 24),
            OnboardingPrimaryButton(
              label: 'Send Reset Link',
              isLoading: isLoading,
              onPressed: _sendResetLink,
            ),
            const AuthFlexibleGap(height: 15),
            Center(
              child: TextButton(
                onPressed: isLoading
                    ? null
                    : () => Navigator.pushReplacementNamed(
                        context,
                        AppRouteNames.login,
                      ),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.authLink,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text.rich(
                  TextSpan(
                    style: AppTextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                    children: [
                      TextSpan(text: 'Remember your account? '),
                      TextSpan(
                        text: 'Login',
                        style: AppTextStyle(
                          color: AppColors.authLink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
