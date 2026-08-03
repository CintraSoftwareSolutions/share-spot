import 'package:flutter/foundation.dart';

import 'package:sharespot/core/constants/app_images.dart';
import 'package:sharespot/features/shared/profile/models/favorite_location.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = 'Alex Carter';
  String _email = 'alexcarter67@gmail.com';
  String _location = 'Madrid, Spain';
  String _vehicleType = 'Sedan';
  String _make = '2015';
  String _model = 'Camry';
  String _licensePlate = 'LSE-3233';
  bool _isLoading = false;

  String get name => _name;
  String get email => _email;
  String get location => _location;
  String get vehicleType => _vehicleType;
  String get make => _make;
  String get model => _model;
  String get licensePlate => _licensePlate;
  bool get isLoading => _isLoading;

  List<FavoriteLocation> get favoriteLocations => const [
    FavoriteLocation(
      name: 'East Village Residence',
      address: '124 E 14th St, New York, NY',
      arrivalTime: 'Arrive by 6:00 PM',
      reliability: '94%',
      image: AppImages.bellaItallino,
    ),
    FavoriteLocation(
      name: 'The Highline Hub',
      address: '450 W 33rd St, New York, NY',
      arrivalTime: 'Arrive by 8:45 AM',
      reliability: '28%',
      image: AppImages.tropicalParadise,
      isCritical: true,
    ),
  ];

  Future<bool> saveProfile({
    required String name,
    required String email,
    required String location,
  }) async {
    return _run(() {
      _name = name;
      _email = email;
      _location = location;
    });
  }

  Future<bool> saveVehicle({
    required String vehicleType,
    required String make,
    required String model,
    required String licensePlate,
  }) async {
    return _run(() {
      _vehicleType = vehicleType;
      _make = make;
      _model = model;
      _licensePlate = licensePlate;
    });
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return _run(() {});
  }

  Future<bool> _run(VoidCallback update) async {
    if (_isLoading) return false;
    _isLoading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 350));
    update();
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
