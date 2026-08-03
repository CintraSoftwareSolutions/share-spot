class AuthService {
  const AuthService();

  Future<void> signIn({required String email, required String password}) async {
    // Replace with Firebase/API authentication without changing the UI layer.
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  Future<void> signInWithProvider(String provider) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
