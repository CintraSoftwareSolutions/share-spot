import 'package:flutter/foundation.dart';

import 'package:sharespot/features/common/auth/services/auth_service.dart';

enum AuthStatus { idle, loading, success, failure }

class AuthProvider extends ChangeNotifier {
  AuthProvider({required AuthService authService}) : _authService = authService;

  final AuthService _authService;
  AuthStatus _status = AuthStatus.idle;
  bool _obscurePassword = true;
  String? _errorMessage;

  AuthStatus get status => _status;
  bool get obscurePassword => _obscurePassword;
  bool get isLoading => _status == AuthStatus.loading;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<bool> signIn({required String email, required String password}) async {
    return _run(() => _authService.signIn(email: email, password: password));
  }

  Future<bool> socialSignIn(String provider) {
    return _run(() => _authService.signInWithProvider(provider));
  }

  Future<bool> _run(Future<void> Function() request) async {
    if (isLoading) return false;
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await request();
      _status = AuthStatus.success;
      notifyListeners();
      return true;
    } on Object {
      _status = AuthStatus.failure;
      _errorMessage = 'Sign in failed. Please try again.';
      notifyListeners();
      return false;
    }
  }
}
