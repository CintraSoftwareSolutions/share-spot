import 'package:flutter/material.dart';

import 'app/app_bootstrap.dart';
import 'core/utils/debug_rendering.dart';

void main() {
  initializeShareSpotBinding();

  installDebugRenderingGuard();

  runApp(const AppBootstrap());
}
