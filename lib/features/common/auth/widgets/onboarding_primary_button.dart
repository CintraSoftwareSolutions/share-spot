import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'auth_button_label.dart';

class OnboardingPrimaryButton extends StatelessWidget {
  const OnboardingPrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.outlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.surfaceDeep,
            ),
          )
        : AuthButtonLabel(label);

    return SizedBox(
      width: double.infinity,
      height: context.authButtonHeight,
      child: outlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.loginGreen,
                side: const BorderSide(color: AppColors.loginGreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: child,
            )
          : FilledButton(
              onPressed: isLoading ? null : onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.loginGreen,
                foregroundColor: AppColors.surfaceDeep,
                disabledBackgroundColor: AppColors.loginGreen.withValues(
                  alpha: 0.55,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: child,
            ),
    );
  }
}
