import 'package:flutter/foundation.dart';

class NotificationSettingsProvider extends ChangeNotifier {
  bool _parkingAlerts = true;
  bool _matchRequests = true;
  bool _messages = true;
  bool _arrivalAlerts = true;
  bool _promotions = true;
  bool _pushNotifications = true;
  bool _isLoading = false;

  bool get parkingAlerts => _parkingAlerts;
  bool get matchRequests => _matchRequests;
  bool get messages => _messages;
  bool get arrivalAlerts => _arrivalAlerts;
  bool get promotions => _promotions;
  bool get pushNotifications => _pushNotifications;
  bool get isLoading => _isLoading;

  void setParkingAlerts(bool value) => _set(
    current: _parkingAlerts,
    value: value,
    update: () => _parkingAlerts = value,
  );

  void setMatchRequests(bool value) => _set(
    current: _matchRequests,
    value: value,
    update: () => _matchRequests = value,
  );

  void setMessages(bool value) =>
      _set(current: _messages, value: value, update: () => _messages = value);

  void setArrivalAlerts(bool value) => _set(
    current: _arrivalAlerts,
    value: value,
    update: () => _arrivalAlerts = value,
  );

  void setPromotions(bool value) => _set(
    current: _promotions,
    value: value,
    update: () => _promotions = value,
  );

  void setPushNotifications(bool value) => _set(
    current: _pushNotifications,
    value: value,
    update: () => _pushNotifications = value,
  );

  Future<bool> save() async {
    if (_isLoading) return false;
    _isLoading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 350));
    _isLoading = false;
    notifyListeners();
    return true;
  }

  void _set({
    required bool current,
    required bool value,
    required VoidCallback update,
  }) {
    if (current == value) return;
    update();
    notifyListeners();
  }
}
