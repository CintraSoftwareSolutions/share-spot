import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sharespot/core/routes/app_route_names.dart';
import 'package:sharespot/features/shared/messages/models/conversation_filter.dart';
import 'package:sharespot/features/shared/messages/widgets/messages_view.dart';
import 'package:sharespot/features/host/messages/providers/host_messages_provider.dart';

class HostMessagesScreen extends StatelessWidget {
  const HostMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.select<HostMessagesProvider, ConversationFilter>(
      (provider) => provider.filter,
    );
    final conversations = context.watch<HostMessagesProvider>().conversations;

    return MessagesView(
      filter: filter,
      conversations: conversations,
      onSearch: context.read<HostMessagesProvider>().search,
      onFilterSelected: context.read<HostMessagesProvider>().selectFilter,
      onConversationSelected: (conversation) => Navigator.pushNamed(
        context,
        AppRouteNames.hostChatDetail,
        arguments: conversation,
      ),
    );
  }
}
