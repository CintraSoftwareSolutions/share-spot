import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/constants/app_constants.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/core/widgets/app_primary_button.dart';
import 'package:sharespot/core/widgets/app_state_view.dart';
import 'package:sharespot/core/widgets/responsive_content.dart';
import 'package:sharespot/features/guest/home/models/share_item.dart';
import 'package:sharespot/features/guest/home/providers/home_provider.dart';
import 'package:sharespot/features/guest/home/widgets/home_header.dart';
import 'package:sharespot/features/guest/home/widgets/home_stats.dart';
import 'package:sharespot/features/guest/home/widgets/share_items_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.isMobile ? kToolbarHeight : 64,
        title: const Text(
          AppConstants.appName,
          style: AppTextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRouteNames.settings),
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ResponsiveContent(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(onSearch: context.read<HomeProvider>().search),
            const SizedBox(height: 28),
            Selector<HomeProvider, (int, int)>(
              selector: (_, provider) =>
                  (provider.totalItems, provider.mediaItems),
              builder: (_, stats, _) =>
                  HomeStats(totalItems: stats.$1, mediaItems: stats.$2),
            ),
            const SizedBox(height: 30),
            Text(
              'Recent shares',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            const _HomeItems(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('New share'),
      ),
    );
  }
}

class _HomeItems extends StatelessWidget {
  const _HomeItems();

  @override
  Widget build(BuildContext context) {
    final status = context.select<HomeProvider, HomeStatus>(
      (provider) => provider.status,
    );

    return switch (status) {
      HomeStatus.initial || HomeStatus.loading => const Center(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: CircularProgressIndicator(),
        ),
      ),
      HomeStatus.failure => AppStateView(
        icon: Icons.cloud_off_outlined,
        title: 'Something went wrong',
        message: context.read<HomeProvider>().errorMessage,
        action: AppPrimaryButton(
          label: 'Try again',
          onPressed: context.read<HomeProvider>().loadItems,
        ),
      ),
      HomeStatus.empty => const AppStateView(
        icon: Icons.folder_open_outlined,
        title: 'No shares yet',
        message: 'Create your first share to see it here.',
      ),
      HomeStatus.success => const _SuccessfulItems(),
    };
  }
}

class _SuccessfulItems extends StatelessWidget {
  const _SuccessfulItems();

  @override
  Widget build(BuildContext context) {
    final items = context.select<HomeProvider, List<ShareItem>>(
      (provider) => provider.visibleItems,
    );

    if (items.isEmpty) {
      return const AppStateView(
        icon: Icons.search_off_rounded,
        title: 'No matching items',
        message: 'Try a different search term.',
      );
    }
    return ShareItemsGrid(items: items);
  }
}
