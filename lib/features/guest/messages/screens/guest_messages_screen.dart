import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/features/guest/messages/providers/messages_provider.dart';
import 'package:sharespot/features/shared/messages/models/conversation_filter.dart';
import 'package:sharespot/features/shared/messages/widgets/messages_view.dart';

class GuestMessagesScreen extends StatelessWidget {
  const GuestMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.select<MessagesProvider, ConversationFilter>(
      (provider) => provider.filter,
    );
    final conversations = context.watch<MessagesProvider>().conversations;
    return MessagesView(
      filter: filter,
      conversations: conversations,
      onSearch: context.read<MessagesProvider>().search,
      onFilterSelected: context.read<MessagesProvider>().selectFilter,
      onConversationSelected: (conversation) => Navigator.pushNamed(
        context,
        AppRouteNames.chatDetail,
        arguments: conversation,
      ),
    );
  }
}
