import 'package:SenCash/src/models/CreateClient.dart';

import '../config.dart';
import '../models/UserModel.dart';
import '../repositories/ApiRepository.dart';

class UserService {
  final ApiRepository _apiRepository;

  UserService({required ApiRepository apiRepository,})  : _apiRepository = apiRepository;

  // Créer un utilisateur
  Future<UserModel?> createUser(CreateClient createClientDto) async {
    final response = await _apiRepository.post('/users/register/client', createClientDto.toJson());
    if (response['statusCode'] == 200) {
      return UserModel.fromJson(response['data']);
    }
    return null;
  }

  // Obtenir un utilisateur par ID
  Future<UserModel?> getUserById(int id) async {
    final response = await _apiRepository.get('/users/$id');
    if (response['statusCode'] == 200) {
      return UserModel.fromJson(response['data']);
    }
    return null;
  }

  // Obtenir tous les utilisateurs
  Future<List<UserModel>> getAllUsers() async {
    final response = await _apiRepository.get('/users');
    if (response['statusCode'] == 200) {
      final List data = response['data'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  // Supprimer un utilisateur par ID
  Future<bool> deleteUserById(int id) async {
    final response = await _apiRepository.delete('/users/$id');
    return response['statusCode'] == 200;
  }

  // Obtenir un utilisateur par numéro de téléphone
  Future<UserModel?> getUserByPhoneNumber(String phoneNumber) async {
    final response = await _apiRepository.get('/users/telephone/$phoneNumber');
    if (response['statusCode'] == 200) {
      return UserModel.fromJson(response['data']);
    }
    return null;
  }

  // Obtenir un utilisateur par email
  Future<UserModel?> getUserByEmail(String email) async {
    final response = await _apiRepository.get('/users/email/$email');
    if (response['statusCode'] == 200) {
      return UserModel.fromJson(response['data']);
    }
    return null;
  }

  // Obtenir les utilisateurs par rôle
  Future<List<UserModel>> getUsersByRoleId(int roleId) async {
    final response = await _apiRepository.get('/users/role/$roleId');
    if (response['statusCode'] == 200) {
      final List data = response['data'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  // Obtenir les utilisateurs actifs
  Future<List<UserModel>> getActiveUsers() async {
    final response = await _apiRepository.get('/users/active');
    if (response['statusCode'] == 200) {
      final List data = response['data'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  // Récupérer le profil utilisateur en utilisant le token
  Future<UserModel?> getUserProfile() async {
    final response = await _apiRepository.get('/users/profile');
    if (response['statusCode'] == 200) {
      return UserModel.fromJson(response['data']);
    } else {
      print("Erreur : ${response['message']}");
    }
    return null;
  }
}
