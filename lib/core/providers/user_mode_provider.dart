import 'package:flutter/foundation.dart';

enum AppUserMode { guest, host }

class UserModeProvider extends ChangeNotifier {
  AppUserMode _mode = AppUserMode.guest;

  AppUserMode get mode => _mode;
  bool get isGuest => _mode == AppUserMode.guest;
  bool get isHost => _mode == AppUserMode.host;

  void switchTo(AppUserMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
  }

  void reset() => switchTo(AppUserMode.guest);
}
