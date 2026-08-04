import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/providers/user_mode_provider.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/common/auth/providers/auth_provider.dart';
import 'auth_divider.dart';
import 'auth_flexible_gap.dart';
import 'auth_text_field.dart';
import 'onboarding_primary_button.dart';
import 'social_login_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    final success = await context.read<AuthProvider>().signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted || !success) return;
    _openHome();
  }

  Future<void> _socialSignIn(String provider) async {
    final success = await context.read<AuthProvider>().socialSignIn(provider);
    if (!mounted || !success) return;
    _openHome();
  }

  void _openHome() {
    context.read<UserModeProvider>().reset();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouteNames.home,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthProvider, bool>(
      (provider) => provider.isLoading,
    );
    final errorMessage = context.select<AuthProvider, String?>(
      (provider) => provider.errorMessage,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = context.isCompactHeight;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: AppTextStyles.display.copyWith(
                  color: AppColors.white,
                  fontSize: 20,
                ),
              ),
              AuthFlexibleGap(height: compact ? 4 : 7),
              const Text(
                'Sign in to continue finding parking spots.',
                style: AppTextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              AuthFlexibleGap(height: compact ? 4 : 29),
              AuthTextField(
                controller: _emailController,
                label: 'Email Address',
                hintText: 'Alexs66@gmail.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.mail_outline_rounded,
                  color: AppColors.iconMuted,
                  size: 20,
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty) return 'Please enter your email address';
                  if (!email.contains('@') || !email.contains('.')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              AuthFlexibleGap(height: compact ? 2 : 18),
              Selector<AuthProvider, bool>(
                selector: (_, provider) => provider.obscurePassword,
                builder: (context, obscurePassword, _) {
                  return AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: '••••••••',
                    obscureText: obscurePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _signIn(),
                    suffixIcon: IconButton(
                      onPressed: context
                          .read<AuthProvider>()
                          .togglePasswordVisibility,
                      tooltip: obscurePassword
                          ? 'Show password'
                          : 'Hide password',
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.iconSubtle,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value!.length < 6) {
                        return 'Password must contain at least 6 characters';
                      }
                      return null;
                    },
                  );
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pushNamed(
                          context,
                          AppRouteNames.forgotPassword,
                        ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.authLink,
                    padding: EdgeInsets.symmetric(vertical: compact ? 4 : 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: AppTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (errorMessage != null) ...[
                AuthFlexibleGap(height: compact ? 4 : 8),
                Text(
                  errorMessage,
                  style: const AppTextStyle(
                    color: AppColors.redAccent,
                    fontSize: 12,
                  ),
                ),
              ],
              AuthFlexibleGap(height: compact ? 4 : 30),
              OnboardingPrimaryButton(
                label: 'Login',
                isLoading: isLoading,
                onPressed: _signIn,
              ),
              AuthFlexibleGap(height: compact ? 2 : 22),
              const AuthDivider(),
              AuthFlexibleGap(height: compact ? 4 : 34),
              SocialLoginButton(
                label: 'Google',
                leading: Image.asset(
                  AppImages.google,
                  width: 19,
                  height: 19,
                  fit: BoxFit.contain,
                ),
                onPressed: isLoading ? null : () => _socialSignIn('google'),
              ),
              AuthFlexibleGap(height: compact ? 4 : 6),
              SocialLoginButton(
                label: 'Apple',
                leading: SvgPicture.asset(
                  AppImages.whiteApple,
                  width: 19,
                  height: 19,
                ),
                onPressed: isLoading ? null : () => _socialSignIn('apple'),
              ),
              AuthFlexibleGap(height: compact ? 0 : 22),
              Center(
                child: TextButton(
                  key: const ValueKey('login-sign-up'),
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pushNamed(
                          context,
                          AppRouteNames.createAccount,
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
                        color: AppColors.hexFFA9ACB4,
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Sign up',
                          style: AppTextStyle(
                            color: AppColors.authLink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
