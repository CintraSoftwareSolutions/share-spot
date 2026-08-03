import 'package:flutter/material.dart';

import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:sharespot/features/shared/messages/models/chat_conversation.dart';
import 'package:sharespot/features/shared/messages/models/conversation_filter.dart';
import 'package:sharespot/features/shared/messages/widgets/chat_filter_tabs.dart';
import 'package:sharespot/features/shared/messages/widgets/conversation_card.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({
    required this.filter,
    required this.conversations,
    required this.onSearch,
    required this.onFilterSelected,
    required this.onConversationSelected,
    super.key,
  });

  final ConversationFilter filter;
  final List<ChatConversation> conversations;
  final ValueChanged<String> onSearch;
  final ValueChanged<ConversationFilter> onFilterSelected;
  final ValueChanged<ChatConversation> onConversationSelected;

  @override
  Widget build(BuildContext context) {
    final padding = context.isMobile ? 20.0 : 32.0;
    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(padding, 22, padding, 17),
              child: Text(
                'Chats',
                style: AppTextStyles.subheading.copyWith(
                  color: AppColors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: TextField(
                onChanged: onSearch,
                style: const AppTextStyle(color: AppColors.white, fontSize: 13),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search conversations...',
                  hintStyle: const AppTextStyle(
                    color: AppColors.hexFF9EA1A9,
                    fontSize: 12.5,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.hexFFC2C4C9,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: AppColors.authField,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: AppColors.authBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(color: AppColors.loginGreen),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: ChatFilterTabs(
                selected: filter,
                onSelected: onFilterSelected,
              ),
            ),
            const SizedBox(height: 17),
            Expanded(
              child: conversations.isEmpty
                  ? const Center(
                      child: Text(
                        'No conversations found.',
                        style: AppTextStyle(color: AppColors.textMuted),
                      ),
                    )
                  : ListView.separated(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(padding, 0, padding, 24),
                      itemCount: conversations.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final conversation = conversations[index];
                        return ConversationCard(
                          conversation: conversation,
                          onTap: () => onConversationSelected(conversation),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
