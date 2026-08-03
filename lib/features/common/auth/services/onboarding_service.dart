class OnboardingService {
  const OnboardingService();

  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
  }

  Future<void> verifyEmail(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }

  Future<void> saveProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  Future<void> saveVehicle({
    required String vehicleType,
    required String model,
    required String year,
    required String licensePlate,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }

  Future<void> finishPermissions() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  Future<void> requestPasswordReset(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }

  Future<void> resetPassword(String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }
}
