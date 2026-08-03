import 'package:flutter/material.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/widgets/app_search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.onSearch, super.key});

  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back',
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Everything you share, organized in one place.',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
    final search = SizedBox(
      width: context.isMobile ? double.infinity : 340,
      child: AppSearchField(
        hintText: 'Search shared items',
        onChanged: onSearch,
      ),
    );

    if (context.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [heading, const SizedBox(height: 20), search],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: heading),
        const SizedBox(width: 24),
        search,
      ],
    );
  }
}
