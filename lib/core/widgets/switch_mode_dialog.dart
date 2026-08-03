import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/providers/user_mode_provider.dart';
import 'package:sharespot/core/theme/app_colors.dart';

class SwitchModeDialog extends StatelessWidget {
  const SwitchModeDialog({required this.targetMode, super.key});

  final AppUserMode targetMode;

  @override
  Widget build(BuildContext context) {
    final targetLabel = targetMode == AppUserMode.host ? 'Host' : 'Guest';
    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 22 : 80,
        vertical: 24,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.borderDialog),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: AppColors.hexFFE8FFE9,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_horiz_rounded,
                      color: AppColors.hexFF299A38,
                      size: 21,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context, false),
                    tooltip: 'Close',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.iconLight,
                      size: 21,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Switch to $targetLabel?',
                style: const AppTextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Are you sure you want to continue in $targetLabel mode?',
                style: const AppTextStyle(
                  color: AppColors.textSoft,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: context.screenWidth,
                height: 54,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.loginGreen,
                    foregroundColor: AppColors.buttonInk,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Switch to $targetLabel',
                    style: const AppTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: context.screenWidth,
                height: 54,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context, false),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.hexFF17191E,
                    side: const BorderSide(color: AppColors.borderDialog),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: AppTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
