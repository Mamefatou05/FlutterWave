import 'package:flutter/cupertino.dart';
import '../models/CreateClient.dart';
import '../models/UserModel.dart';
import '../repositories/ApiRepository.dart';

class UserService {
  final ApiRepository _apiRepository;

  UserService({required ApiRepository apiRepository}) : _apiRepository = apiRepository;

  Future<UserModel?> createUser(CreateClient createClientDto) async {
    final response = await _apiRepository.post('/users/register/client', createClientDto.toJson());
    return response.data != null ? UserModel.fromJson(response.data) : null;
  }

  Future<UserModel?> getUserById(int id) async {
    final response = await _apiRepository.get('/users/$id');
    return response.data != null ? UserModel.fromJson(response.data) : null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final response = await _apiRepository.get('/users');
    if (response.data is List) {
      return (response.data as List).map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<bool> deleteUserById(int id) async {
    final response = await _apiRepository.delete('/users/$id');
    return response.status == 'SUCCESS';
  }

  Future<UserModel?> getUserByPhoneNumber(String phoneNumber) async {
    final response = await _apiRepository.get('/users/telephone/$phoneNumber');
    return response.data != null ? UserModel.fromJson(response.data) : null;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final response = await _apiRepository.get('/users/email/$email');
    return response.data != null ? UserModel.fromJson(response.data) : null;
  }

  Future<List<UserModel>> getUsersByRoleId(int roleId) async {
    final response = await _apiRepository.get('/users/role/$roleId');
    if (response.data is List) {
      return (response.data as List).map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<UserModel>> getActiveUsers() async {
    final response = await _apiRepository.get('/users/active');
    if (response.data is List) {
      return (response.data as List).map((json) => UserModel.fromJson(json)).toList();
    }
    return [];
  }

  Future<UserModel?> getUserProfile() async {
    try {
      final response = await _apiRepository.get('/users/profile');
      return response.data != null ? UserModel.fromJson(response.data) : null;
    } catch (e, stackTrace) {
      debugPrint("Erreur dans getUserProfile: $e");
      debugPrint("Stack trace: $stackTrace");
      return null;
    }
  }
}
