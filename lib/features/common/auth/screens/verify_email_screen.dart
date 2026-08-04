import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/common/auth/providers/onboarding_provider.dart';
import 'package:sharespot/features/common/auth/widgets/auth_flexible_gap.dart';
import 'package:sharespot/features/common/auth/widgets/auth_sheet_heading.dart';
import 'package:sharespot/features/common/auth/widgets/gradient_auth_scaffold.dart';
import 'package:sharespot/features/common/auth/widgets/onboarding_primary_button.dart';
import 'package:sharespot/features/common/auth/widgets/otp_code_input.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  Timer? _timer;
  int _secondsRemaining = 30;
  String _code = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  Future<void> _verify() async {
    if (_code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the complete 6-digit code.')),
      );
      return;
    }
    final success = await context.read<OnboardingProvider>().verifyEmail(_code);
    if (!mounted || !success) return;
    Navigator.pushNamed(context, AppRouteNames.profileSetup);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final email = provider.email.isEmpty ? 'you@example.com' : provider.email;

    return GradientAuthScaffold(
      headerFraction: context.isCompactHeight ? 0.25 : 0.58,
      logoAlignment: const Alignment(0, 0.25),
      topPadding: context.isCompactHeight ? 18 : 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthSheetHeading(
            title: 'Verify Email',
            subtitle:
                'A 6-digit code was sent to $email.\nEnter it below to unlock your dashboard.',
          ),
          const AuthFlexibleGap(height: 28),
          OtpCodeInput(onChanged: (value) => _code = value),
          const AuthFlexibleGap(height: 28),
          Center(
            child: Text.rich(
              TextSpan(
                style: const AppTextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
                children: [
                  TextSpan(
                    text:
                        '00:${_secondsRemaining.toString().padLeft(2, '0')} Sec - ',
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: _secondsRemaining == 0
                          ? () => setState(_startTimer)
                          : null,
                      child: Text(
                        'Resend Code',
                        style: AppTextStyle(
                          color: _secondsRemaining == 0
                              ? AppColors.authLink
                              : AppColors.hexFF858993,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const AuthFlexibleGap(height: 32),
          OnboardingPrimaryButton(
            label: 'Verify',
            isLoading: provider.isLoading,
            onPressed: _verify,
          ),
        ],
      ),
    );
  }
}
