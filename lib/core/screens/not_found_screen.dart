import 'package:flutter/material.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/widgets/app_primary_button.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, this.routeName});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: context.pagePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.route_outlined, size: 56),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(routeName ?? 'Unknown route'),
              const SizedBox(height: 24),
              AppPrimaryButton(
                label: 'Back to home',
                icon: Icons.home_outlined,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouteNames.home,
                  (_) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
