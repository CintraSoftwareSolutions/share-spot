class ChatConversation {
  const ChatConversation({
    required this.name,
    required this.preview,
    required this.time,
    required this.rating,
    required this.status,
    required this.meta,
    this.isCompleted = false,
    this.isVerified = true,
  });

  final String name;
  final String preview;
  final String time;
  final double rating;
  final String status;
  final String meta;
  final bool isCompleted;
  final bool isVerified;
}
