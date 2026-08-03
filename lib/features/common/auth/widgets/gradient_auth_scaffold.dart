import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_gradients.dart';
import 'auth_header.dart';

class GradientAuthScaffold extends StatelessWidget {
  const GradientAuthScaffold({
    required this.child,
    super.key,
    this.headerFraction = 0.3,
    this.logoAlignment = Alignment.center,
    this.horizontalPadding = 24,
    this.topPadding = 30,
    this.showBack = false,
  });

  final Widget child;
  final double headerFraction;
  final Alignment logoAlignment;
  final double horizontalPadding;
  final double topPadding;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final keyboardHeight = context.keyboardHeight;
    final keyboardVisible = context.isKeyboardVisible;
    const sheetOverlap = 24.0;
    final minimumHeaderHeight = context.isCompactHeight ? 104.0 : 150.0;
    final headerHeight = (screenHeight * headerFraction)
        .clamp(minimumHeaderHeight, screenHeight * 0.72)
        .toDouble();
    final regularSheetTop = headerHeight - sheetOverlap;
    final minimumKeyboardTop = context.safeAreaPadding.top + 56;
    final maximumKeyboardShift = (regularSheetTop - minimumKeyboardTop)
        .clamp(0.0, regularSheetTop)
        .toDouble();
    final keyboardShift = keyboardVisible
        ? (keyboardHeight * 0.65).clamp(0.0, maximumKeyboardShift).toDouble()
        : 0.0;
    final sheetTop = regularSheetTop - keyboardShift;
    final sheetHeight = screenHeight - regularSheetTop;
    final sidePadding = screenWidth < 600 ? horizontalPadding : 40.0;
    final designBottomPadding = context.isCompactHeight ? 12.0 : 16.0;
    final bottomPadding = context.bottomSafeArea > designBottomPadding
        ? context.bottomSafeArea
        : designBottomPadding;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: AppColors.authSurface,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.transparent,
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppGradients.splash),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: headerHeight,
                child: AuthHeader(
                  height: headerHeight,
                  alignment: logoAlignment,
                ),
              ),
              if (showBack)
                Positioned(
                  top: 0,
                  left: context.isMobile ? 6 : 18,
                  child: SafeArea(
                    bottom: false,
                    child: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      tooltip: 'Back',
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.surfaceDeep,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              AnimatedPositioned(
                duration: AppConstants.animationDuration,
                curve: Curves.easeOutCubic,
                top: sheetTop,
                left: 0,
                right: 0,
                height: sheetHeight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.authSurface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(
                    sidePadding,
                    topPadding,
                    sidePadding,
                    bottomPadding,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final contentWidth = constraints.maxWidth
                          .clamp(0.0, 500.0)
                          .toDouble();

                      return Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(width: contentWidth, child: child),
                      );
                    },
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
