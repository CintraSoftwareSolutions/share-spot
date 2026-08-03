import 'package:flutter/material.dart';
import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/widgets/responsive_content.dart';
import 'package:sharespot/features/common/settings/widgets/theme_mode_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.isMobile ? kToolbarHeight : 64,
        title: const Text('Settings'),
      ),
      body: ResponsiveContent(
        maxWidth: 720,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose how ${AppConstants.appName} looks on this device.',
              style: AppTextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ThemeModeSelector(),
            ),
          ],
        ),
      ),
    );
  }
}
