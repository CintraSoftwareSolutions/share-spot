import 'package:flutter/foundation.dart';

import 'package:sharespot/features/guest/home/models/share_item.dart';
import 'package:sharespot/features/guest/home/services/home_service.dart';

enum HomeStatus { initial, loading, success, empty, failure }

class HomeProvider extends ChangeNotifier {
  HomeProvider({required HomeService homeService}) : _homeService = homeService;

  final HomeService _homeService;
  List<ShareItem> _items = const [];
  HomeStatus _status = HomeStatus.initial;
  String _query = '';
  String? _errorMessage;

  HomeStatus get status => _status;
  String? get errorMessage => _errorMessage;
  String get query => _query;

  List<ShareItem> get visibleItems {
    if (_query.isEmpty) return List.unmodifiable(_items);
    final normalizedQuery = _query.toLowerCase();
    return List.unmodifiable(
      _items.where(
        (item) =>
            item.title.toLowerCase().contains(normalizedQuery) ||
            item.subtitle.toLowerCase().contains(normalizedQuery),
      ),
    );
  }

  int get totalItems => _items.length;

  int get mediaItems => _items
      .where(
        (item) =>
            item.category == ShareCategory.image ||
            item.category == ShareCategory.video,
      )
      .length;

  Future<void> loadItems() async {
    _status = HomeStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _items = await _homeService.fetchItems();
      _status = _items.isEmpty ? HomeStatus.empty : HomeStatus.success;
    } on Object {
      _status = HomeStatus.failure;
      _errorMessage = 'Could not load your shared items. Please try again.';
    }
    notifyListeners();
  }

  void search(String value) {
    final nextQuery = value.trim();
    if (_query == nextQuery) return;
    _query = nextQuery;
    notifyListeners();
  }
}
