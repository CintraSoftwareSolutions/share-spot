class AppNotification {
  const AppNotification({
    required this.title,
    required this.message,
    this.isUnread = false,
  });

  final String title;
  final String message;
  final bool isUnread;
}
