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
  Future<bool> login(LoginModel loginModel) async {
    try {
      final jwtResponse = await _authService.login(loginModel);
      if (jwtResponse != null) {
        _jwtModel = jwtResponse;
        notifyListeners();
        return true;  // Retourne true si la connexion est réussie
      } else {
        return false;  // Retourne false si la réponse est nulle ou échoue
      }
    } catch (e) {
      print(e);
      return false;  // En cas d'erreur, retourne false
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await _authService.logout();
    _jwtModel = null;
    notifyListeners();
  }
}
