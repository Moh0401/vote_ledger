import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> login({
    required String id,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    // TODO: API LOGIN

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }
}