import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:flutter/services.dart';

import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/theme/app_gradients.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _navigationTimer = Timer(AppConstants.splashDuration, _openHome);
  }

  void _openHome() {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRouteNames.login);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logoFontSize = (context.screenWidth * 0.092)
        .clamp(32.0, 36.0)
        .toDouble();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.transparent,
        systemNavigationBarColor: AppColors.authLink,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(gradient: AppGradients.splash),
          child: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Text(
                    AppConstants.appName,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading.copyWith(
                      fontSize: logoFontSize,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: context.isMobile ? 20 : 28,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.isMobile ? 24 : 40,
                    ),
                    child: Text(
                      'Find parking before someone else does.',
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
