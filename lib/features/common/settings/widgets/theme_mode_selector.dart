import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/features/common/settings/providers/app_settings_provider.dart';

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedMode = context.select<AppSettingsProvider, ThemeMode>(
      (provider) => provider.themeMode,
    );

    return SegmentedButton<ThemeMode>(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
          value: ThemeMode.system,
          icon: Icon(Icons.settings_suggest_outlined),
          label: Text('System'),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode_outlined),
          label: Text('Light'),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode_outlined),
          label: Text('Dark'),
        ),
      ],
      selected: {selectedMode},
      onSelectionChanged: (selection) {
        context.read<AppSettingsProvider>().setThemeMode(selection.first);
      },
    );
  }
}
