import 'package:flutter/material.dart';

import 'package:sharespot/features/guest/home/models/share_item.dart';
import 'share_item_card.dart';

class ShareItemsGrid extends StatelessWidget {
  const ShareItemsGrid({required this.items, super.key});

  final List<ShareItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1000
            ? 4
            : constraints.maxWidth >= 680
            ? 3
            : constraints.maxWidth >= 440
            ? 2
            : 1;

        return GridView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 210,
          ),
          itemBuilder: (_, index) =>
              ShareItemCard(key: ValueKey(items[index].id), item: items[index]),
        );
      },
    );
  }
}
