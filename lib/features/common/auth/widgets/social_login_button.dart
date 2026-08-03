import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'auth_button_label.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    required this.label,
    required this.leading,
    required this.onPressed,
    super.key,
  });

  final String label;
  final Widget leading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.authButtonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.authField,
          side: const BorderSide(color: AppColors.authBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(dimension: 20, child: Center(child: leading)),
            const SizedBox(width: 10),
            Flexible(child: AuthButtonLabel(label)),
          ],
        ),
      ),
    );
  }
}
