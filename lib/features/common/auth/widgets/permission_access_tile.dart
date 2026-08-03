import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'auth_button_label.dart';

class PermissionAccessTile extends StatelessWidget {
  const PermissionAccessTile({
    required this.label,
    required this.isAllowed,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool isAllowed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 54),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.authField,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.authBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const AppTextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: context.authInlineButtonWidth,
            height: context.authInlineButtonHeight,
            child: FilledButton(
              onPressed: isAllowed ? null : onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.authLink,
                disabledBackgroundColor: AppColors.loginGreen.withValues(
                  alpha: 0.18,
                ),
                disabledForegroundColor: AppColors.loginGreen,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: AuthButtonLabel(
                isAllowed ? 'Allowed' : 'Allow Access',
                style: AppTextStyles.authInlineButtonLabel,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
