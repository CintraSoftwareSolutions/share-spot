import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/routes/app_router.dart';
import 'package:sharespot/core/theme/app_theme.dart';
import 'package:sharespot/core/utils/debug_rendering.dart';
import 'package:sharespot/features/common/settings/providers/app_settings_provider.dart';

class ShareSpotApp extends StatelessWidget {
  const ShareSpotApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Hot reload rebuilds this widget without running main() again.
    installDebugRenderingGuard();
    final themeMode = context.select<AppSettingsProvider, ThemeMode>(
      (provider) => provider.themeMode,
    );

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      initialRoute: AppRouteNames.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
