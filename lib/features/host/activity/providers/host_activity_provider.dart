import 'package:flutter/foundation.dart';

import 'package:sharespot/features/shared/activity/models/parking_activity.dart';
import 'package:sharespot/features/shared/activity/models/activity_filter.dart';

class HostActivityProvider extends ChangeNotifier {
  ActivityFilter _filter = ActivityFilter.completed;

  ActivityFilter get filter => _filter;

  static const _completed = [
    ParkingActivity(
      place: 'Downtown Plaza',
      date: 'May 25, 2026',
      address: 'Guest: Sarah Wilson',
      host: 'Tesla Model 3 • Black',
      status: 'ARRIVING IN 15 MIN',
      points: 50,
    ),
    ParkingActivity(
      place: 'Central Mall',
      date: 'May 22, 2026',
      address: 'Guest: Michael Carter',
      host: 'Audi e-tron • Blue',
      status: 'COMPLETED',
      points: 35,
    ),
    ParkingActivity(
      place: 'Harbor Center',
      date: 'May 20, 2026',
      address: 'Guest: Elena Johnson',
      host: 'Audi e-tron • Silver',
      status: 'COMPLETED',
      points: 40,
    ),
  ];

  static const _upcoming = [
    ParkingActivity(
      place: 'Central Mall Parking',
      date: 'Today • 2:45 PM',
      address: 'Guest: Marcus T.',
      host: 'Tesla Model 3 • Midnight Silver',
      status: 'UPCOMING',
      points: 50,
    ),
    ParkingActivity(
      place: 'Downtown Plaza',
      date: 'Tomorrow • 10:30 AM',
      address: 'Guest: Elena V.',
      host: 'Audi e-tron • Silver',
      status: 'UPCOMING',
      points: 35,
    ),
  ];

  static const _cancelled = [
    ParkingActivity(
      place: 'Westfield Garage',
      date: 'May 4, 2026',
      address: 'Guest: Daniel Kim',
      host: 'Request cancelled',
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
