import 'package:flutter/foundation.dart';

import 'package:sharespot/features/common/auth/services/onboarding_service.dart';

class OnboardingProvider extends ChangeNotifier {
  OnboardingProvider({required OnboardingService onboardingService})
    : _onboardingService = onboardingService;

  final OnboardingService _onboardingService;

  bool _isLoading = false;
  bool _acceptsTerms = false;
  bool _obscurePassword = true;
  bool _locationAllowed = false;
  bool _notificationsAllowed = false;
  String _email = '';
  String _vehicleType = 'Sedan';
  String _vehicleModel = 'Camry';

  bool get isLoading => _isLoading;
  bool get acceptsTerms => _acceptsTerms;
  bool get obscurePassword => _obscurePassword;
  bool get locationAllowed => _locationAllowed;
  bool get notificationsAllowed => _notificationsAllowed;
  String get email => _email;
  String get vehicleType => _vehicleType;
  String get vehicleModel => _vehicleModel;

  void toggleTerms(bool? value) {
    _acceptsTerms = value ?? false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void setVehicleType(String? value) {
    if (value == null || value == _vehicleType) return;
    _vehicleType = value;
    notifyListeners();
  }

  void setVehicleModel(String? value) {
    if (value == null || value == _vehicleModel) return;
    _vehicleModel = value;
    notifyListeners();
  }

  void allowLocation() {
    _locationAllowed = true;
    notifyListeners();
  }

  void allowNotifications() {
    _notificationsAllowed = true;
    notifyListeners();
  }

  Future<bool> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    _email = email;
    return _run(
      () => _onboardingService.createAccount(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<bool> verifyEmail(String code) {
    return _run(() => _onboardingService.verifyEmail(code));
  }

  Future<bool> saveProfile() {
    return _run(_onboardingService.saveProfile);
  }

  Future<bool> saveVehicle({
    required String year,
    required String licensePlate,
  }) {
    return _run(
      () => _onboardingService.saveVehicle(
        vehicleType: _vehicleType,
        model: _vehicleModel,
        year: year,
        licensePlate: licensePlate,
      ),
    );
  }

  Future<bool> finishPermissions() {
    return _run(_onboardingService.finishPermissions);
  }

  Future<bool> requestPasswordReset(String email) {
    _email = email;
    return _run(() => _onboardingService.requestPasswordReset(email));
  }

  Future<bool> resetPassword(String password) {
    return _run(() => _onboardingService.resetPassword(password));
  }

  Future<bool> _run(Future<void> Function() request) async {
    if (_isLoading) return false;
    _isLoading = true;
    notifyListeners();
    try {
      await request();
      return true;
    } on Object {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
