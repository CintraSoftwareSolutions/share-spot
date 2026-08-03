import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/features/guest/home/models/share_item.dart';

class ShareItemCard extends StatelessWidget {
  const ShareItemCard({required this.item, super.key});

  final ShareItem item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        _iconFor(item.category),
                        color: colors.onSecondaryContainer,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    tooltip: 'More options',
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                item.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 14),
              Text(
                _dateLabel(item.sharedAt),
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(ShareCategory category) {
    return switch (category) {
      ShareCategory.document => Icons.description_outlined,
      ShareCategory.image => Icons.image_outlined,
      ShareCategory.video => Icons.play_circle_outline,
      ShareCategory.link => Icons.link_rounded,
    };
  }

  String _dateLabel(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
