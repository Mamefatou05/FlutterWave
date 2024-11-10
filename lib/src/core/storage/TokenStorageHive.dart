import 'package:hive/hive.dart';
import 'TokenStorageInterface.dart';

class TokenStorageHive implements TokenStorageInterface {
  late Box<String> _box;

  TokenStorageHive() {
    _box = Hive.box('secureBox');  // Assurez-vous d'ouvrir la boîte Hive avant utilisation
  }

  @override
  Future<void> saveToken(String token) async {
    await _box.put('jwt', token);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    await _box.put('refresh_token', refreshToken);
  }

  @override
  Future<String?> getToken() async {
    return _box.get('jwt');
  }

  @override
  Future<String?> getRefreshToken() async {
    return _box.get('refresh_token');
  }

  @override
  Future<void> deleteToken() async {
    await _box.delete('jwt');
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _box.delete('refresh_token');
  }

  @override
  Future<void> deleteAllTokens() async {
    await _box.delete('jwt');
    await _box.delete('refresh_token');
  }
}
