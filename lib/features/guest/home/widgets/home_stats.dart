import 'package:flutter/material.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'home_stat_card.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({
    required this.totalItems,
    required this.mediaItems,
    super.key,
  });

  final int totalItems;
  final int mediaItems;

  @override
  Widget build(BuildContext context) {
    final cards = [
      HomeStatCard(
        label: 'Total shares',
        value: '$totalItems',
        icon: Icons.folder_copy_outlined,
      ),
      HomeStatCard(
        label: 'Media files',
        value: '$mediaItems',
        icon: Icons.perm_media_outlined,
      ),
    ];

    if (context.isMobile) {
      return Column(
        children: [
          for (var index = 0; index < cards.length; index++) ...[
            SizedBox(width: double.infinity, child: cards[index]),
            if (index != cards.length - 1) const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (var index = 0; index < cards.length; index++) ...[
          Expanded(child: cards[index]),
          if (index != cards.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}
