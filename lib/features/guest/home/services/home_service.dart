import 'package:sharespot/features/guest/home/models/share_item.dart';

class HomeService {
  const HomeService();

  Future<List<ShareItem>> fetchItems() async {
    // Replace this seed data with a repository/API call. The provider and UI
    // do not need to change when the data source changes.
    return [
      ShareItem(
        id: '1',
        title: 'Project brief',
        subtitle: 'Shared with Design Team',
        category: ShareCategory.document,
        sharedAt: DateTime(2026, 7, 30, 14, 30),
      ),
      ShareItem(
        id: '2',
        title: 'Product shots',
        subtitle: '12 images',
        category: ShareCategory.image,
        sharedAt: DateTime(2026, 7, 29, 18, 15),
      ),
      ShareItem(
        id: '3',
        title: 'Launch walkthrough',
        subtitle: '08:42 minutes',
        category: ShareCategory.video,
        sharedAt: DateTime(2026, 7, 28, 11),
      ),
      ShareItem(
        id: '4',
        title: 'Research board',
        subtitle: 'Public link',
        category: ShareCategory.link,
        sharedAt: DateTime(2026, 7, 27, 9, 45),
      ),
    ];
  }
}
