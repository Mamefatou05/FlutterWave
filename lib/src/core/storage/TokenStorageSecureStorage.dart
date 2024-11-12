import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'TokenStorageInterface.dart';

class TokenStorageSecureStorage implements TokenStorageInterface {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt', value: token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt');
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt');
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: 'refresh_token');
  }

  @override
  Future<void> deleteAllTokens() async {
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'refresh_token');
  }
}
