enum ShareCategory { document, image, video, link }

class ShareItem {
  const ShareItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.sharedAt,
  });

  final String id;
  final String title;
  final String subtitle;
  final ShareCategory category;
  final DateTime sharedAt;
}
