import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_colors.dart';

abstract final class AppGradients {
  static const LinearGradient splash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.loginGreen, AppColors.authLink],
    stops: [0, 0.4437],
  );
}
