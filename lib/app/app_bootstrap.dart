import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app_providers.dart';
import 'sharespot_app.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.create(),
      child: const ShareSpotApp(),
    );
  }
}
