import 'package:flutter/foundation.dart';

class ParkingInsightsProvider extends ChangeNotifier {
  bool _isPrimaryDestination = true;

  bool get isPrimaryDestination => _isPrimaryDestination;

  void setPrimaryDestination(bool value) {
    if (_isPrimaryDestination == value) return;
    _isPrimaryDestination = value;
    notifyListeners();
  }
}
