import 'package:flutter/foundation.dart';

import 'package:sharespot/features/shared/activity/models/parking_activity.dart';
import 'package:sharespot/features/shared/activity/models/activity_filter.dart';

class ActivityProvider extends ChangeNotifier {
  ActivityFilter _filter = ActivityFilter.completed;

  ActivityFilter get filter => _filter;

  static const _completed = [
    ParkingActivity(
      place: 'Central Mall',
      date: 'May 25, 2026',
      address: 'Host: Marcus',
      host: 'Tesla Model 3 • Blue',
      status: 'ARRIVING IN 15 MIN',
      points: 50,
    ),
    ParkingActivity(
      place: 'Harbor Plaza',
      date: 'May 22, 2026',
      address: 'Host: Elena',
      host: 'Audi e-tron • Silver',
      status: 'COMPLETED',
      points: 35,
    ),
    ParkingActivity(
      place: 'Lakeside Villas',
      date: 'May 20, 2026',
      address: 'Host: Jasmine',
      host: 'BMW iX • Blue',
      status: 'COMPLETED',
      points: 40,
    ),
  ];

  static const _upcoming = [
    ParkingActivity(
      place: 'Harbor Plaza',
      date: 'Today • 2:45 PM',
      address: 'Host: Elena',
      host: 'Tesla Model 3 • Silver',
      status: 'UPCOMING',
      points: 50,
    ),
    ParkingActivity(
      place: 'Central Mall',
      date: 'Tomorrow • 10:30 AM',
      address: 'Host: Marcus',
      host: 'Level B2 • Spot 18',
      status: 'UPCOMING',
      points: 35,
    ),
  ];

  static const _cancelled = [
    ParkingActivity(
      place: 'Westfield Garage',
      date: 'May 4, 2026',
      address: 'Host: Daniel',
      host: 'Cancelled by host',
      status: 'CANCELLED',
      points: 0,
    ),
  ];

  List<ParkingActivity> get activities => switch (_filter) {
    ActivityFilter.upcoming => _upcoming,
    ActivityFilter.completed => _completed,
    ActivityFilter.cancelled => _cancelled,
  };

  void selectFilter(ActivityFilter filter) {
    if (_filter == filter) return;
    _filter = filter;
    notifyListeners();
  }
}
