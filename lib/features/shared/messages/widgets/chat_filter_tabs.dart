import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/messages/models/conversation_filter.dart';

class ChatFilterTabs extends StatelessWidget {
  const ChatFilterTabs({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final ConversationFilter selected;
  final ValueChanged<ConversationFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Wrap(
        spacing: 10,
        children: [
          _FilterChip(
            label: 'Active',
            selected: selected == ConversationFilter.active,
            onTap: () => onSelected(ConversationFilter.active),
          ),
          _FilterChip(
            label: 'Completed',
            selected: selected == ConversationFilter.completed,
            onTap: () => onSelected(ConversationFilter.completed),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.loginGreen : AppColors.authField,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.isMobile ? 17 : 21,
            vertical: 8,
          ),
          child: Text(
            label,
            style: AppTextStyle(
              color: selected ? AppColors.authSurface : AppColors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
