import 'package:flutter/material.dart';
import '../models/LoginModel.dart';
import '../services/AuthService.dart';
import '../models/JwtModel.dart';
class AuthProvider with ChangeNotifier {
  JwtModel? _jwtModel;
  final AuthService _authService;

  AuthProvider(this._authService);

  JwtModel? get jwtModel => _jwtModel;

  // Connexion : modifiez pour accepter un objet LoginModel
  Future<void> login(LoginModel loginModel) async {
    final jwtResponse = await _authService.login(loginModel);
    if (jwtResponse != null) {
      _jwtModel = jwtResponse;
      notifyListeners();
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await _authService.logout();
    _jwtModel = null;
    notifyListeners();
  }
}
