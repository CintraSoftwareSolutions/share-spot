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

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    final provider = context.read<OnboardingProvider>();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!provider.acceptsTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms to continue.')),
      );
      return;
    }
    final success = await provider.createAccount(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted || !success) return;
    Navigator.pushNamed(context, AppRouteNames.verifyEmail);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<OnboardingProvider, bool>(
      (provider) => provider.isLoading,
    );
    return GradientAuthScaffold(
      headerFraction: context.isCompactHeight ? 0.18 : 0.38,
      topPadding: context.isCompactHeight ? 18 : 24,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthSheetHeading(
              title: 'Create your account',
              subtitle: 'Create a profile to find and reserve parking spots.',
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 8 : 24),
            AuthTextField(
              controller: _nameController,
              label: 'Name',
              hintText: 'Alex Carter',
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.person_outline_rounded,
                color: AppColors.iconMuted,
                size: 20,
              ),
              validator: (value) => (value ?? '').trim().isEmpty
                  ? 'Please enter your name'
                  : null,
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 8 : 16),
            AuthTextField(
              controller: _emailController,
              label: 'Email Address',
              hintText: 'alexcarter57@gmail.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              prefixIcon: const Icon(
                Icons.mail_outline_rounded,
                color: AppColors.iconMuted,
                size: 20,
              ),
              validator: (value) {
                final email = value?.trim() ?? '';
                if (!email.contains('@') || !email.contains('.')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 8 : 16),
            Selector<OnboardingProvider, bool>(
              selector: (_, provider) => provider.obscurePassword,
              builder: (context, obscurePassword, _) {
                return AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: '••••••••',
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _createAccount(),
                  suffixIcon: IconButton(
                    onPressed: context
                        .read<OnboardingProvider>()
                        .togglePasswordVisibility,
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.iconMuted,
                      size: 20,
                    ),
                  ),
                  validator: (value) => (value ?? '').length < 6
                      ? 'Use at least 6 characters'
                      : null,
                );
              },
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 6 : 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 20,
                  child: Selector<OnboardingProvider, bool>(
                    selector: (_, provider) => provider.acceptsTerms,
                    builder: (context, acceptsTerms, _) => Checkbox(
                      value: acceptsTerms,
                      onChanged: context.read<OnboardingProvider>().toggleTerms,
                      activeColor: AppColors.authLink,
                      side: const BorderSide(color: AppColors.hexFF8E929C),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'I agree to the Terms & Conditions and Privacy Policy',
                    style: AppTextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11.5,
                    ),
                  ),
                ),
              ],
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 8 : 18),
            OnboardingPrimaryButton(
              label: 'Create Account',
              isLoading: isLoading,
              onPressed: _createAccount,
            ),
            AuthFlexibleGap(height: context.isCompactHeight ? 6 : 16),
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
                  padding: EdgeInsets.symmetric(
                    vertical: context.isCompactHeight ? 3 : 8,
                  ),
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
                      TextSpan(text: 'Already have an account? '),
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
