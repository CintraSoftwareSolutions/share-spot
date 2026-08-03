import 'package:flutter/foundation.dart';

import 'package:sharespot/features/shared/messages/models/chat_conversation.dart';
import 'package:sharespot/features/shared/messages/models/conversation_filter.dart';

class HostMessagesProvider extends ChangeNotifier {
  ConversationFilter _filter = ConversationFilter.active;
  String _query = '';
  final Set<String> _completedExchanges = {};
  int _rating = 0;

  ConversationFilter get filter => _filter;
  int get rating => _rating;

  static const _activeConversations = [
    ChatConversation(
      name: 'Elena V.',
      preview: 'Perfect, see you in a bit!',
      time: '45 min ago',
      rating: 5,
      status: 'Handover Pending',
      meta: '0.1 miles away',
    ),
    ChatConversation(
      name: 'Marcus T.',
      preview: 'On my way, almost there!',
      time: '30 min ago',
      rating: 4.8,
      status: 'Handover Pending',
      meta: '0.3 miles away',
    ),
    ChatConversation(
      name: 'Omar Khalid',
      preview: 'Just arrived, ready to go!',
      time: '15 min ago',
      rating: 4.9,
      status: 'Handover Pending',
      meta: '0.2 miles away',
    ),
    ChatConversation(
      name: 'James K.',
      preview: "Here, let's get started!",
      time: '10 min ago',
      rating: 4.7,
      status: 'Handover Pending',
      meta: '0.4 miles away',
    ),
  ];

  static const _completedConversations = [
    ChatConversation(
      name: 'Marco Alvarez',
      preview: 'Thanks! Enjoy the spot.',
      time: 'Yesterday',
      rating: 4.9,
      status: 'Completed',
      meta: '50 Points Earned',
      isCompleted: true,
    ),
    ChatConversation(
      name: 'Jessica Chen',
      preview: 'Great coordination. Safe travels!',
      time: '2 Days Ago',
      rating: 4.9,
      status: 'Completed',
      meta: '50 Points Earned',
      isCompleted: true,
    ),
    ChatConversation(
      name: 'Noah Bennett',
      preview: 'Thanks for being on time.',
      time: '3 Days Ago',
      rating: 4.7,
      status: 'Completed',
      meta: '75 Points Earned',
      isCompleted: true,
    ),
  ];

  List<ChatConversation> get conversations {
    final source = _filter == ConversationFilter.active
        ? _activeConversations
        : _completedConversations;
    if (_query.isEmpty) return source;
    return source
        .where(
          (conversation) =>
              conversation.name.toLowerCase().contains(_query) ||
              conversation.preview.toLowerCase().contains(_query),
        )
        .toList(growable: false);
  }

  void selectFilter(ConversationFilter filter) {
    if (_filter == filter) return;
    _filter = filter;
    notifyListeners();
  }

  void search(String value) {
    final query = value.trim().toLowerCase();
    if (_query == query) return;
    _query = query;
    notifyListeners();
  }

  bool isExchangeCompleted(ChatConversation conversation) {
    return conversation.isCompleted ||
        _completedExchanges.contains(conversation.name);
  }

  void completeExchange(String conversationName) {
    if (_completedExchanges.contains(conversationName)) return;
    _completedExchanges.add(conversationName);
    notifyListeners();
  }

  void submitRating(int value) {
    _rating = value;
    notifyListeners();
  }
}
