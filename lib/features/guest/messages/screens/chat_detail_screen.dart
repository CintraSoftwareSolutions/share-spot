import 'package:flutter/material.dart';
import 'package:sharespot/core/theme/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/core/extensions/build_context_extension.dart';
import 'package:sharespot/core/theme/app_colors.dart';
import 'package:sharespot/features/shared/messages/models/chat_conversation.dart';
import 'package:sharespot/features/guest/messages/providers/messages_provider.dart';
import 'package:sharespot/features/shared/messages/widgets/arrival_confirmation_card.dart';
import 'package:sharespot/features/shared/messages/widgets/chat_message_bubble.dart';
import 'package:sharespot/features/shared/messages/widgets/live_location_card.dart';
import 'package:sharespot/features/shared/messages/widgets/parking_handover_card.dart';
import 'package:sharespot/features/shared/messages/widgets/parking_rating_sheet.dart';
import 'package:sharespot/features/shared/messages/widgets/swap_completed_card.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key, this.conversation});

  final ChatConversation? conversation;

  static const _fallbackConversation = ChatConversation(
    name: 'Elena V.',
    preview: 'Perfect, see you in a bit!',
    time: '45 min ago',
    rating: 5,
    status: 'Handover Pending',
    meta: '0.1 miles away',
  );

  Future<void> _showRating(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.transparent,
      barrierColor: AppColors.black.withValues(alpha: 0.72),
      builder: (_) => ParkingRatingSheet(
        onSubmit: context.read<MessagesProvider>().submitRating,
      ),
    );
  }

  Future<void> _confirmArrival(
    BuildContext context,
    ChatConversation selectedConversation,
  ) async {
    context.read<MessagesProvider>().completeExchange(
      selectedConversation.name,
    );
    if (!context.mounted) return;
    await _showRating(context);
  }

  @override
  Widget build(BuildContext context) {
    final selectedConversation = conversation ?? _fallbackConversation;
    final exchangeCompleted = context.select<MessagesProvider, bool>(
      (provider) => provider.isExchangeCompleted(selectedConversation),
    );
    final padding = context.isMobile ? 18.0 : 30.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _ChatHeader(
              conversation: selectedConversation,
              isCompleted: exchangeCompleted,
              onBack: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(padding, 10, padding, 18),
                children: [
                  ParkingHandoverCard(isCompleted: exchangeCompleted),
                  const SizedBox(height: 25),
                  const _TodayDivider(),
                  const SizedBox(height: 19),
                  ChatMessageBubble(
                    message:
                        "Hey ${selectedConversation.name.split(' ').first}! I'm at the north entrance of Harbor Plaza. Where exactly are you?",
                    time: '14:02',
                    isMine: true,
                  ),
                  const SizedBox(height: 17),
                  const LiveLocationCard(),
                  const SizedBox(height: 17),
                  const ChatMessageBubble(
                    message:
                        'Just turned onto the main strip. Arriving in a minute!',
                    time: '14:05',
                    isMine: false,
                  ),
                  const SizedBox(height: 21),
                  const Divider(color: AppColors.authBorder),
                  const SizedBox(height: 10),
                  if (exchangeCompleted)
                    SwapCompletedCard(onTap: () => _showRating(context))
                  else
                    ArrivalConfirmationCard(
                      onConfirm: () =>
                          _confirmArrival(context, selectedConversation),
                    ),
                ],
              ),
            ),
            const _MessageComposer(),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.conversation,
    required this.isCompleted,
    required this.onBack,
  });

  final ChatConversation conversation;
  final bool isCompleted;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 64),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            tooltip: 'Back',
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.white,
              size: 21,
            ),
          ),
          const CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage(AppImages.profile),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.name,
                  style: const AppTextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 3,
                      backgroundColor: AppColors.loginGreen,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        isCompleted
                            ? 'Exchange completed'
                            : 'Handover in progress',
                        maxLines: 2,
                        style: const AppTextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'More options',
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.white,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayDivider extends StatelessWidget {
  const _TodayDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.authBorder)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.authField,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              child: Text(
                'Today',
                style: AppTextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.authBorder)),
      ],
    );
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.isMobile ? 18 : 30,
        8,
        context.isMobile ? 18 : 30,
        10,
      ),
      child: TextField(
        style: const AppTextStyle(color: AppColors.white, fontSize: 12.5),
        textInputAction: TextInputAction.send,
        decoration: InputDecoration(
          hintText: 'Type what you have in mind...',
          hintStyle: const AppTextStyle(
            color: AppColors.hexFF8E9198,
            fontSize: 12,
          ),
          suffixIcon: const Icon(
            Icons.mic_none_rounded,
            color: AppColors.hexFFC5C7CC,
            size: 19,
          ),
          filled: true,
          fillColor: AppColors.authField,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 11,
          ),
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
    );
  }
}
