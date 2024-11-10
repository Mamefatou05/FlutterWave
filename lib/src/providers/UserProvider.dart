import 'package:SenCash/src/services/UserService.dart';
import 'package:flutter/material.dart';
import '../models/LoginModel.dart';
import '../models/CreateClient.dart';
import '../services/AuthService.dart';
import '../models/JwtModel.dart';

class UserProvider with ChangeNotifier {

  final UserService _userService;

  UserProvider( this._userService);


  // Enregistrement : accepte un objet CreateClient directement
  Future<bool> register(CreateClient createClient) async {
    try {
      final response = await _userService.createUser(createClient);
      if (response != null) {
        notifyListeners();
        return true; // Succès
      }
    } catch (e) {
      // Gestion d'erreur si nécessaire
      print("Erreur lors de l'enregistrement : $e");
    }
    return false; // Échec
  }
}
