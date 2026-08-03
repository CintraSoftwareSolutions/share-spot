import 'package:flutter/material.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class ProfilePageScaffold extends StatelessWidget {
  const ProfilePageScaffold({
    required this.title,
    required this.child,
    super.key,
    this.actionLabel,
    this.onAction,
    this.isLoading = false,
  });

  final String title;
  final Widget child;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: context.isMobile ? 92 : 104,
              width: context.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: context.isMobile ? 4 : 16),
                    child: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      tooltip: 'Back',
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: Text(
                      title,
                      style: AppTextStyles.subheading.copyWith(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(width: context.screenWidth, child: child),
            ),
            if (actionLabel != null)
              Padding(
                padding: EdgeInsets.fromLTRB(padding, 12, padding, 16),
                child: SizedBox(
                  width: context.screenWidth,
                  height: 56,
                  child: FilledButton(
                    onPressed: isLoading ? null : onAction,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.loginGreen,
                      foregroundColor: AppColors.buttonInk,
                      disabledBackgroundColor: AppColors.loginGreen.withValues(
                        alpha: 0.55,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox.square(
                            dimension: 19,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.buttonInk,
                            ),
                          )
                        : Text(
                            actionLabel!,
                            style: const AppTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
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
