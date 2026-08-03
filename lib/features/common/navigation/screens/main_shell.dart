import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/providers/user_mode_provider.dart';
import 'package:sharespot/features/guest/navigation/screens/guest_main_shell.dart';
import 'package:sharespot/features/host/navigation/screens/host_main_shell.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.select<UserModeProvider, AppUserMode>(
      (provider) => provider.mode,
    );
    return mode == AppUserMode.host
        ? const HostMainShell()
        : const GuestMainShell();
  }
}
