import 'package:flutter/foundation.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void select(int index) {
    if (index == _selectedIndex || index < 0 || index > 4) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void reset() => select(0);
}
