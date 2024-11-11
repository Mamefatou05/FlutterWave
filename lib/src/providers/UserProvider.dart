import 'package:flutter/material.dart';
import '../models/UserModel.dart';
import '../models/CreateClient.dart'; // Assurez-vous que ce modèle est importé
import '../services/UserService.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService;
  UserModel? _user;
  bool _loading = false;
  String? _error;

  UserProvider(this._userService) {
    debugPrint("UserProvider créé. Début du chargement de loadUserProfile.");
    loadUserProfile();
  }

  bool get loading => _loading;
  UserModel? get user => _user;
  String? get error => _error;

  Future<void> loadUserProfile() async {
    try {
      debugPrint("Chargement du profil utilisateur...");
      _loading = true;
      _error = null;
      notifyListeners();

      _user = await _userService.getUserProfile();
      debugPrint("Profil utilisateur chargé avec détails:");
      debugPrint("ID: ${_user?.id}");
      debugPrint("Nom: ${_user?.nomComplet}");
      debugPrint("Téléphone: ${_user?.numeroTelephone}");
      debugPrint("Email: ${_user?.email}");
      debugPrint("Solde: ${_user?.solde}");
      debugPrint("Statut: ${_user!.estActif ? 'Actif' : 'Inactif'}");
      debugPrint("Role: ${_user?.role?.toString()}");
      debugPrint("Nombre de transactions envoyées: ${_user?.transactionsEnvoyees.length}");
      debugPrint("Nombre de transactions reçues: ${_user?.transactionsRecues.length}");

    } catch (e, stackTrace) {
      debugPrint("Erreur lors du chargement du profil utilisateur : $e");
      debugPrint("Stack trace: $stackTrace");
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
      debugPrint("Chargement terminé.");
    }
  }

  Future<void> refreshUser() async {
    await loadUserProfile();
  }

  void setUser(UserModel user) {
    _user = user;
    _error = null;
    notifyListeners();
    debugPrint("Utilisateur mis à jour: $user");
  }

  void clearUser() {
    _user = null;
    _error = null;
    notifyListeners();
    debugPrint("Utilisateur déconnecté");
  }

  Future<bool> register(CreateClient createClient) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      debugPrint("Début de l'enregistrement pour: ${createClient.nomComplet}");
      final response = await _userService.createUser(createClient);

      if (response != null) {
        _user = response;
        debugPrint("Enregistrement réussi pour: ${response.nomComplet}");
        return true;
      }
      _error = "L'enregistrement a échoué";
      return false;

    } catch (e, stackTrace) {
      debugPrint("Erreur lors de l'enregistrement : $e");
      debugPrint("Stack trace: $stackTrace");
      _error = e.toString();
      return false;

    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Méthode utilitaire pour vérifier si l'utilisateur est un client
  bool get isClient => _user?.role?.nom?.toUpperCase() == 'CLIENT';

  // Méthode utilitaire pour vérifier si l'utilisateur est un agent
  bool get isAgent => _user?.pointAgent != null;

  // Méthode utilitaire pour vérifier si l'utilisateur est un marchand
  bool get isMarchand => _user?.marchand != null;
}